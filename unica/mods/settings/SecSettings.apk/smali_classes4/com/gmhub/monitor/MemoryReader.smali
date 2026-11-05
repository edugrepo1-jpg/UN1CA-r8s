.class public final Lcom/gmhub/monitor/MemoryReader;
.super Ljava/lang/Object;
.source "MemoryReader.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/monitor/MemoryReader$Snapshot;
    }
.end annotation


# static fields
.field private static final KEYS:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Ljava/util/HashSet;

    const-string v5, "SwapTotal"

    const-string v6, "SwapFree"

    const-string v1, "MemTotal"

    const-string v2, "MemAvailable"

    const-string v3, "Active"

    const-string v4, "Cached"

    filled-new-array/range {v1 .. v6}, [Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    sput-object v0, Lcom/gmhub/monitor/MemoryReader;->KEYS:Ljava/util/Set;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/Long;Ljava/lang/Long;)Ljava/lang/Long;
    .locals 0

    invoke-static {p0, p1}, Lcom/gmhub/monitor/MemoryReader;->used(Ljava/lang/Long;Ljava/lang/Long;)Ljava/lang/Long;

    move-result-object p0

    return-object p0
.end method

.method static synthetic lambda$zram$0(Ljava/io/File;)Z
    .locals 1

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object p0

    const-string v0, "zram[0-9]{1,2}"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method public static read(Ljava/io/File;Ljava/io/File;)Lcom/gmhub/monitor/MemoryReader$Snapshot;
    .locals 10

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    const/high16 v2, 0x10000

    :try_start_0
    invoke-static {p0, v2}, Lcom/gmhub/monitor/MemoryReader;->read(Ljava/io/File;I)Ljava/lang/String;

    move-result-object p0

    const-string v2, "\n"

    invoke-virtual {p0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    array-length v2, p0

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    if-ge v4, v2, :cond_6

    aget-object v5, p0, v4

    const/16 v6, 0x3a

    invoke-virtual {v5, v6}, Ljava/lang/String;->indexOf(I)I

    move-result v6

    if-gez v6, :cond_0

    goto :goto_1

    :cond_0
    invoke-virtual {v5, v3, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    sget-object v8, Lcom/gmhub/monitor/MemoryReader;->KEYS:Ljava/util/Set;

    invoke-interface {v8, v7}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_1

    goto :goto_1

    :cond_1
    invoke-interface {v1, v7}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_2

    invoke-interface {v0, v7}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_2
    add-int/lit8 v6, v6, 0x1

    invoke-virtual {v5, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    const-string v6, "\\s+"

    invoke-virtual {v5, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    array-length v6, v5

    const/4 v8, 0x2

    if-ne v6, v8, :cond_5

    const/4 v6, 0x1

    aget-object v6, v5, v6

    const-string v8, "kB"

    invoke-virtual {v6, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_3

    goto :goto_1

    :cond_3
    aget-object v5, v5, v3

    invoke-static {v5}, Lcom/gmhub/monitor/MemoryReader;->unsigned(Ljava/lang/String;)J

    move-result-wide v5

    const-wide v8, 0x1fffffffffffffL

    cmp-long v8, v5, v8

    if-lez v8, :cond_4

    goto :goto_1

    :cond_4
    const-wide/16 v8, 0x400

    mul-long/2addr v5, v8

    invoke-static {v5, v6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    invoke-interface {v0, v7, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_1

    :catch_0
    :cond_5
    :goto_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :catch_1
    :cond_6
    new-instance p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;

    invoke-static {p1}, Lcom/gmhub/monitor/MemoryReader;->zram(Ljava/io/File;)[Ljava/lang/Long;

    move-result-object p1

    invoke-direct {p0, v0, p1}, Lcom/gmhub/monitor/MemoryReader$Snapshot;-><init>(Ljava/util/Map;[Ljava/lang/Long;)V

    return-object p0
.end method

.method private static read(Ljava/io/File;I)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    new-instance v0, Ljava/io/InputStreamReader;

    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    sget-object p0, Ljava/nio/charset/StandardCharsets;->US_ASCII:Ljava/nio/charset/Charset;

    invoke-direct {v0, v1, p0}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    :try_start_0
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    :goto_0
    if-gt v1, p1, :cond_2

    invoke-virtual {v0}, Ljava/io/Reader;->read()I

    move-result v2

    const/4 v3, -0x1

    if-ne v2, v3, :cond_0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v0}, Ljava/io/Reader;->close()V

    return-object p0

    :cond_0
    if-eq v1, p1, :cond_1

    int-to-char v2, v2

    :try_start_1
    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Oversized memory field"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_2
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Invalid memory field"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catchall_0
    move-exception p0

    :try_start_2
    invoke-virtual {v0}, Ljava/io/Reader;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p1

    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_1
    throw p0
.end method

.method private static unsigned(Ljava/lang/String;)J
    .locals 2

    const-string v0, "[0-9]{1,19}"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    return-wide v0

    :cond_0
    new-instance p0, Ljava/lang/NumberFormatException;

    const-string v0, "Unsigned bytes required"

    invoke-direct {p0, v0}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static used(Ljava/lang/Long;Ljava/lang/Long;)Ljava/lang/Long;
    .locals 4

    if-eqz p0, :cond_1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-virtual {p0}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide p0

    sub-long/2addr v0, p0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    return-object p0

    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static zram(Ljava/io/File;)[Ljava/lang/Long;
    .locals 18

    const/4 v0, 0x3

    :try_start_0
    new-instance v1, Lcom/gmhub/monitor/MemoryReader$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/gmhub/monitor/MemoryReader$$ExternalSyntheticLambda0;-><init>()V

    move-object/from16 v2, p0

    invoke-virtual {v2, v1}, Ljava/io/File;->listFiles(Ljava/io/FileFilter;)[Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_5

    array-length v2, v1

    if-eqz v2, :cond_5

    array-length v2, v1

    const/16 v3, 0x10

    if-le v2, v3, :cond_0

    goto/16 :goto_2

    :cond_0
    array-length v2, v1

    const-wide/16 v4, 0x0

    move-wide v7, v4

    move-wide v9, v7

    move-wide v11, v9

    const/4 v6, 0x0

    :goto_0
    if-ge v6, v2, :cond_4

    aget-object v13, v1, v6

    new-instance v14, Ljava/io/File;

    const-string v15, "disksize"

    invoke-direct {v14, v13, v15}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const/16 v15, 0x40

    invoke-static {v14, v15}, Lcom/gmhub/monitor/MemoryReader;->read(Ljava/io/File;I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v14

    invoke-static {v14}, Lcom/gmhub/monitor/MemoryReader;->unsigned(Ljava/lang/String;)J

    move-result-wide v14

    cmp-long v16, v14, v4

    if-nez v16, :cond_1

    move-object/from16 v17, v1

    const/16 p0, 0x0

    goto :goto_1

    :cond_1
    const/16 p0, 0x0

    new-instance v3, Ljava/io/File;

    const-string v4, "mm_stat"

    invoke-direct {v3, v13, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const/16 v4, 0x200

    invoke-static {v3, v4}, Lcom/gmhub/monitor/MemoryReader;->read(Ljava/io/File;I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    const-string v4, "\\s+"

    invoke-virtual {v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    array-length v4, v3

    if-ge v4, v0, :cond_2

    new-array v0, v0, [Ljava/lang/Long;

    return-object v0

    :cond_2
    aget-object v4, v3, p0

    invoke-static {v4}, Lcom/gmhub/monitor/MemoryReader;->unsigned(Ljava/lang/String;)J

    move-result-wide v4

    const/4 v13, 0x2

    aget-object v3, v3, v13
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/ArithmeticException; {:try_start_0 .. :try_end_0} :catch_1

    move-object/from16 v17, v1

    :try_start_1
    invoke-static {v3}, Lcom/gmhub/monitor/MemoryReader;->unsigned(Ljava/lang/String;)J

    move-result-wide v0

    cmp-long v3, v4, v14

    if-lez v3, :cond_3

    const/4 v13, 0x3

    new-array v0, v13, [Ljava/lang/Long;

    return-object v0

    :cond_3
    invoke-static {v7, v8, v4, v5}, Ljava/lang/Math;->addExact(JJ)J

    move-result-wide v7

    invoke-static {v9, v10, v14, v15}, Ljava/lang/Math;->addExact(JJ)J

    move-result-wide v9

    invoke-static {v11, v12, v0, v1}, Ljava/lang/Math;->addExact(JJ)J

    move-result-wide v11

    :goto_1
    add-int/lit8 v6, v6, 0x1

    move-object/from16 v1, v17

    const/4 v0, 0x3

    const-wide/16 v4, 0x0

    goto :goto_0

    :cond_4
    invoke-static {v7, v8}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-static {v11, v12}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    filled-new-array {v0, v1, v2}, [Ljava/lang/Long;

    move-result-object v0

    return-object v0

    :cond_5
    :goto_2
    move v13, v0

    new-array v0, v13, [Ljava/lang/Long;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/ArithmeticException; {:try_start_1 .. :try_end_1} :catch_0

    return-object v0

    :catch_0
    const/4 v13, 0x3

    goto :goto_3

    :catch_1
    move v13, v0

    :goto_3
    new-array v0, v13, [Ljava/lang/Long;

    return-object v0
.end method
