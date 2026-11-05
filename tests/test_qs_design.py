"""Measured edit chrome: actual Java geometry, no Android/emulator claims."""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'target/r8s/ui/apple_qs/src/com/gmhub/qs/Ios26Design.java'

HARNESS = r'''import com.gmhub.qs.Ios26Design;
public class DesignContract {
    static int checks;
    static void check(boolean value) { checks++; if(!value)throw new AssertionError("check "+checks); }
    static void near(float a,float b) { check(Math.abs(a-b)<.001f); }
    public static void main(String[] args) {
        for(float density:new float[]{.75f,1f,1.5f,1.6f,2f,2.625f,3f,4f}) {
            // The minimum-size Android target still leaves the center available
            // for moving; it must not accidentally delete or resize a control.
            for(float dp:new float[]{48f,56f,64f,82f}) {
                Ios26Design.Chrome c=new Ios26Design.Chrome(dp*density,dp*density,density,1,1);
                near(c.radius,dp*density/2f);
                check(c.hit(c.width/2,c.height/2,true,true)==Ios26Design.MOVE);
                check(c.hit(c.removeX,c.removeY,true,true)==Ios26Design.REMOVE);
                check(c.hit(c.resizeX,c.resizeY,true,true)==Ios26Design.RESIZE);
                // Corner ownership is explicit even when 48dp tap regions
                // overlap. A disabled resize must never begin a resize gesture.
                check(c.hit(c.resizeX,c.resizeY,true,false)==Ios26Design.MOVE);
                check(c.hit(c.removeX,c.removeY,false,true)==Ios26Design.MOVE);
                check(c.hit(-100*density,0,true,true)==Ios26Design.NONE);
                check(c.hit(Float.NaN,0,true,true)==Ios26Design.NONE);
                check(c.hit(c.removeX-23*density,c.removeY,true,true)==Ios26Design.REMOVE);
                check(c.hit(c.resizeX+23*density,c.resizeY,true,true)==Ios26Design.RESIZE);
                check(c.hitDistance(Ios26Design.REMOVE,c.removeX,c.removeY)==0d);
            }
            // Pixel rounding of the expanded View must not hide a control that
            // meets the 48dp body minimum at a fractional Android density.
            float halo=Ios26Design.HALO_DP*density;
            float measured=(float)Math.ceil(48*density+2*halo)-2*halo;
            Ios26Design.Chrome minimum=new Ios26Design.Chrome(measured,measured,density,1,1);
            check(minimum.hit(measured/2,measured/2,true,true)==Ios26Design.MOVE);
            // A tall slider and a wide focus control have the same capsule ends.
            near(new Ios26Design.Chrome(64*density,144*density,density,1,2).radius,32*density);
            near(new Ios26Design.Chrome(144*density,64*density,density,2,1).radius,32*density);
            check(new Ios26Design.Chrome(144*density,144*density,density,2,2).radius<40*density);
        }
        // Exact invalid inputs are rejected before rendering/hit testing.
        for(float bad:new float[]{0f,-1f,Float.NaN,Float.POSITIVE_INFINITY}) {
            try { new Ios26Design.Chrome(64f,64f,bad,1,1);throw new AssertionError(); }
            catch(IllegalArgumentException expected){check(true);}
        }
        try { new Ios26Design.Chrome(47f,64f,1f,1,1);throw new AssertionError(); }
        catch(IllegalArgumentException expected){check(true);}
        System.out.println(checks+" design geometry checks passed");
    }
}'''


class Ios26DesignTests(unittest.TestCase):
    def test_circular_capsule_and_small_control_touch_ownership(self):
        home = os.environ.get('JAVA_HOME')
        suffix = '.exe' if os.name == 'nt' else ''
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not javac or not java:
            self.skipTest('A complete host JDK is required')
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            harness = out / 'DesignContract.java'
            harness.write_text(HARNESS, encoding='utf-8')
            r = subprocess.run([javac, '--release', '8', '-d', str(out), str(SOURCE), str(harness)],
                               capture_output=True, text=True, timeout=45)
            self.assertEqual(r.returncode, 0, r.stderr)
            r = subprocess.run([java, '-Xverify:all', '-cp', str(out), 'DesignContract'],
                               capture_output=True, text=True, timeout=30)
            self.assertEqual(r.returncode, 0, r.stdout+r.stderr)
            self.assertIn('design geometry checks passed', r.stdout)
