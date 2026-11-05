"""Fault/lifecycle contracts for the native editor completion adapter.

The host substitutes the coroutine boundary, never claims disk persistence or
physical Samsung UI operation. Exact donor signatures are checked separately.
"""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'target/r8s/ui/apple_qs/src/com/gmhub/qs/NativeEditorSave.java'

HARNESS = r'''package com.gmhub.qs;
import java.util.*;
import java.util.concurrent.*;
import java.util.function.Consumer;

public final class NativeSaveContract {
    static int checks;
    static void check(boolean value) { checks++;if(!value)throw new AssertionError("check "+checks); }
    static final class Ui implements Executor {
        final Queue<Runnable> tasks=new ArrayDeque<>();boolean reject;
        public void execute(Runnable task) {
            if(reject)throw new RejectedExecutionException("owner unavailable");
            tasks.add(task);
        }
        void drain(){while(!tasks.isEmpty())tasks.remove().run();}
    }
    static final class Port implements NativeEditorSave.Port {
        boolean current=true,allowed=true,writable=true,inline,throwAfterStart,failPreflight;
        int starts,detaches;
        Consumer<Throwable> completion;
        public boolean isCurrent(){return current;}
        public boolean canFinish(){
            if(failPreflight)throw new IllegalStateException("preflight");
            return allowed;
        }
        public boolean writable(){return writable;}
        public NativeEditorSave.Pending start(Consumer<Throwable> done) {
            starts++;completion=done;
            if(throwAfterStart)throw new IllegalStateException("registration after launch");
            if(inline)done.accept(null);
            return ()->detaches++;
        }
    }
    static final class Fixture {
        final Port port=new Port();final Ui ui=new Ui();
        final NativeEditorSave save=new NativeEditorSave(port,ui);
        int calls;Throwable failure;
        void result(Throwable error){calls++;failure=error;}
        boolean finish(){return save.finish(this::result);}
    }
    public static void main(String[] args) throws Exception {
        Fixture f=new Fixture();check(f.finish());check(!f.finish());check(f.port.starts==1);
        Consumer<Throwable> old=f.port.completion;old.accept(null);old.accept(null);f.ui.drain();
        check(f.calls==1&&f.failure==null);check(f.port.detaches==1);
        check(f.save.status()==NativeEditorSave.Status.IDLE);
        // A stale callback/executor rejection cannot poison a newer request.
        check(f.finish());f.ui.reject=true;old.accept(null);f.ui.reject=false;
        check(f.save.status()==NativeEditorSave.Status.SAVING);
        f.port.completion.accept(null);f.ui.drain();check(f.calls==2);
        // Preflight does not change native edit mode or launch anything.
        f=new Fixture();f.port.allowed=false;check(!f.finish());check(f.calls==0&&f.port.starts==0);
        f=new Fixture();f.port.writable=false;check(!f.finish());check(f.calls==1&&f.failure!=null);
        check(f.port.starts==0&&f.save.status()==NativeEditorSave.Status.IDLE);
        final int[] throwsOnce={0};
        try{f.save.finish(error->{throwsOnce[0]++;throw new IllegalArgumentException("observer");});
            throw new AssertionError("observer failure lost");}
        catch(IllegalArgumentException expected){check(throwsOnce[0]==1);}
        f=new Fixture();f.port.failPreflight=true;check(!f.finish());check(f.calls==1&&f.port.starts==0);
        // A partially dispatched save is unknown, never automatically retried.
        f=new Fixture();f.port.throwAfterStart=true;check(!f.finish());check(f.calls==1&&f.failure!=null);
        check(f.save.status()==NativeEditorSave.Status.UNKNOWN);check(!f.finish());
        f.port.completion.accept(null);f.ui.drain();check(f.calls==1&&f.port.starts==1);
        // Normal completion must still check repository write-safe mode.
        f=new Fixture();check(f.finish());f.port.writable=false;f.port.completion.accept(null);f.ui.drain();
        check(f.calls==1&&f.failure!=null&&f.save.status()==NativeEditorSave.Status.UNKNOWN);
        // Async native failure cannot be described as a successful write.
        f=new Fixture();check(f.finish());Throwable nativeFailure=new IllegalStateException("native IO");
        f.port.completion.accept(nativeFailure);f.ui.drain();check(f.failure==nativeFailure);
        check(f.save.status()==NativeEditorSave.Status.UNKNOWN&&f.port.detaches==1);
        // A disposed/new user's owner receives no stale completion UI update.
        for(boolean switched:new boolean[]{false,true}) {
            f=new Fixture();check(f.finish());
            if(switched)f.port.current=false;else f.save.close();
            f.port.completion.accept(null);f.ui.drain();
            check(f.calls==0&&f.port.detaches==1);check(f.save.status()==NativeEditorSave.Status.CLOSED);
        }
        f=new Fixture();f.port.current=false;check(!f.finish());check(f.port.starts==0);
        check(f.save.status()==NativeEditorSave.Status.CLOSED);
        // Rejection only fails that request; observation occurs on the owner.
        f=new Fixture();check(f.finish());f.ui.reject=true;f.port.completion.accept(null);
        check(f.calls==0);check(f.save.status()==NativeEditorSave.Status.UNKNOWN);
        check(f.calls==1&&f.port.detaches==1&&f.failure instanceof RejectedExecutionException);
        // Already completed jobs can call back inline before returning a handle.
        Port inline=new Port();inline.inline=true;int[] callbacks={0};
        NativeEditorSave immediate=new NativeEditorSave(inline,Runnable::run);
        check(immediate.finish(error->{check(error==null);callbacks[0]++;}));
        check(callbacks[0]==1&&inline.detaches==1&&immediate.status()==NativeEditorSave.Status.IDLE);
        // Reentrant disposal from the callback never cancels Samsung's scope.
        Port closePort=new Port();closePort.inline=true;
        NativeEditorSave closeSave=new NativeEditorSave(closePort,Runnable::run);
        check(closeSave.finish(error->closeSave.close()));
        check(closePort.detaches==1&&closeSave.status()==NativeEditorSave.Status.CLOSED);
        // Native completion can arrive off-thread; the actual state changes on UI.
        f=new Fixture();check(f.finish());final Consumer<Throwable> done=f.port.completion;
        Thread worker=new Thread(()->done.accept(null));worker.start();worker.join();
        check(f.calls==0&&f.save.status()==NativeEditorSave.Status.SAVING);f.ui.drain();check(f.calls==1);
        final NativeEditorSave uiOnly=f.save;final Throwable[] wrongThread={null};
        Thread wrong=new Thread(()->{try{uiOnly.finish(error->{});}catch(Throwable error){wrongThread[0]=error;}});
        wrong.start();wrong.join();check(wrongThread[0] instanceof IllegalStateException);
        // Misconfigured async executors fail on the owner without a background
        // StateFlow/UI write or an uncaught coroutine completion exception.
        Port wrongPort=new Port();int[] wrongCallbacks={0};Throwable[] wrongError={null};
        NativeEditorSave wrongExecutor=new NativeEditorSave(wrongPort,task->{
            Thread thread=new Thread(task);thread.start();
            try{thread.join();}catch(InterruptedException interrupted){throw new IllegalStateException(interrupted);}
        });
        check(wrongExecutor.finish(error->{wrongCallbacks[0]++;wrongError[0]=error;}));
        wrongPort.completion.accept(null);check(wrongCallbacks[0]==0);
        check(wrongExecutor.status()==NativeEditorSave.Status.UNKNOWN);
        check(wrongCallbacks[0]==1&&wrongError[0] instanceof IllegalStateException);
        System.out.println(checks+" native-save lifecycle checks passed");
    }
}'''


class NativeSaveTests(unittest.TestCase):
    def test_completion_failure_and_owner_lifecycle(self):
        home = os.environ.get('JAVA_HOME')
        suffix = '.exe' if os.name == 'nt' else ''
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not javac or not java:
            self.skipTest('A complete host JDK is required')
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            sources = {
                'com/gmhub/qs/NativeSaveContract.java': HARNESS,
                'com/gmhub/qs/SamsungScene.java': '''package com.gmhub.qs;
public class SamsungScene {
  public Object nativeModel(){throw new UnsupportedOperationException();}
  boolean geometryAllowed(){return true;}
  boolean geometryOwned(){return true;}
  boolean geometryInProgress(){return false;}
}''',
            }
            files = [str(SOURCE)]
            for name, content in sources.items():
                path = out / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(content, encoding='utf-8')
                files.append(str(path))
            compiled = subprocess.run([javac, '-encoding', 'UTF-8', '-d', str(out), *files], capture_output=True, text=True, timeout=45)
            self.assertEqual(compiled.returncode, 0, compiled.stderr)
            result = subprocess.run([java, '-Xverify:all', '-cp', str(out), 'com.gmhub.qs.NativeSaveContract'], capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn('native-save lifecycle checks passed', result.stdout)
