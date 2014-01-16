
# Validation

Consolidated instructions to validate components are installed 

- [Maven](#maven)
- [Gradle](#gradle)
- [Hadoop](#hadoop)
- [Hbase](#hbase)
- [Hive](#hive)
- [R](#r)
- [Rhipe](#rhipe) 
- [Scala](#scala)
- [Sbt](#sbt)
- [Spark](#spark)
- [Shark](#shark) (TODO - not compatiable with hive 0.10)

*************

### Maven
```
$ mvnn --version
Apache Maven 3.1.1 (0728685237757ffbf44136acec0402957f723d9a; 2013-09-17 15:22:22+0000)
Maven home: /usr/share/maven
Java version: 1.7.0_45, vendor: Oracle Corporation
Java home: /usr/lib/jvm/java-7-oracle/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "3.2.0-58-generic", arch: "amd64", family: "unix"
```
[top](#validation)

### Gradle
```
------------------------------------------------------------
Gradle 1.10
------------------------------------------------------------

Build time:   2013-12-17 09:28:15 UTC
Build number: none
Revision:     36ced393628875ff15575fa03d16c1349ffe8bb6

Groovy:       1.8.6
Ant:          Apache Ant(TM) version 1.9.2 compiled on July 8 2013
Ivy:          2.2.0
JVM:          1.7.0_45 (Oracle Corporation 24.45-b08)
OS:           Linux 3.2.0-58-generic amd64
```
[top](#validation)

### Hadoop
```
$ hadoop fs -ls /
Found 4 items
drwxr-xr-x   - hbase supergroup          0 2014-01-15 14:10 /hbase
drwxrwxrwt   - hdfs  supergroup          0 2014-01-14 22:49 /tmp
drwxr-xr-x   - hdfs  supergroup          0 2014-01-14 22:50 /user
drwxr-xr-x   - hdfs  supergroup          0 2014-01-14 22:49 /var
```
[top](#validation)

### Hbase 
```
$ hbase shell
14/01/15 14:10:01 WARN conf.Configuration: hadoop.native.lib is deprecated. Instead, use io.native.lib.available
HBase Shell; enter 'help<RETURN>' for list of supported commands.
Type "exit<RETURN>" to leave the HBase Shell
Version 0.94.6-cdh4.5.0, rUnknown, Wed Nov 20 15:48:11 PST 2013

hbase(main):001:0> create 'test','cf'
0 row(s) in 1.1010 seconds

=> Hbase::Table - test
hbase(main):002:0> list
TABLE
test
1 row(s) in 0.9480 seconds
```
[top](#validation)

### Hive
```
$ hive
Logging initialized using configuration in file:/etc/hive/xdata-conf/local/hive-log4j.properties
Hive history file=/tmp/vagrant/hive_job_log_97f4faee-16b4-41b0-8547-26f2ea460605_1152650489.txt
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/lib/zookeeper/lib/slf4j-log4j12-1.6.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/lib/hive/lib/slf4j-log4j12-1.6.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
hive> CREATE TABLE test (foo INT, bar STRING);
OK
Time taken: 3.11 seconds
hive> SHOW TABLES;
OK
test
Time taken: 0.302 seconds
hive> DROP TABLE test;
OK
Time taken: 1.699 seconds
hive>
```
[top](#validation)

### R 
```
$ R --version 
R version 2.14.1 (2011-12-22)
Copyright (C) 2011 The R Foundation for Statistical Computing
ISBN 3-900051-07-0
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License version 2.
For more information about these matters see
http://www.gnu.org/licenses/.
```
[top](#validation)

### Rhipe 
```
$ R
> library(Rhipe)
------------------------------------------------
| Please call rhinit() else RHIPE will not run |
------------------------------------------------
> rhinit()
Rhipe: Using RhipeCDH4.jar
Initializing Rhipe v0.73
SLF4J: Class path contains multiple SLF4J bindings.
....
> x <- list( list("a", 1), list("b", 2))
> rhwrite(x,"/tmp/x")
Wrote 0.48 KB,2 chunks, and 2 elements (100% complete)
> rhread("/tmp/x")
Read 2 objects(0.07 KB) in 0.06 seconds
...
```
[top](#validation)

### Scala
```
$ scala
Welcome to Scala version 2.9.3 (Java HotSpot(TM) 64-Bit Server VM, Java 1.7.0_45).
Type in expressions to have them evaluated.
Type :help for more information.

scala> Range(1,8).map(2*).toList
res0: List[Int] = List(2, 4, 6, 8, 10, 12, 14)
```
[top](#validation)

### Sbt
```
$ sbt --version
Loading /usr/share/sbt/bin/sbt-launch-lib.bash
sbt launcher version 0.13.0
```
[top](#validation)

### Spark
```
$ /srv/software/spark/spark-shell
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 0.7.3
      /_/

Using Scala version 2.9.3 (Java HotSpot(TM) 64-Bit Server VM, Java 1.7.0_45)
Initializing interpreter...

scala> val dir = "hdfs://localhost:8020/tmp"
scala> sc.parallelize(Range(0,100)).saveAsTextFile(dir + "/test")
scala> val file = sc.textFile(dir + "/test")
scala> file.count
res1: Long = 100
scala> file.filter( _.toInt >= 50).count
res1: Long = 50
```
[top](#validation)

### Shark

**TODO currently shark is not compatible with HIVE 0.10 metastore **

https://groups.google.com/forum/#!topic/spark-users/BpTXKEsKcHo 

```bash
$ /srv/software/shark/bin/shark

```
[top](#validation)