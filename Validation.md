
# Validation

Consolidated instructions to validate components are installed 

- [Maven](#maven)
- [Gradle](#gradle)
- [Hadoop](#hadoop)
- [Hbase](#hbase)
- [Hive](#hive)
- [Impala](#impala)
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

### Impala

following instructions from [cloudera impala tutorial](http://www.cloudera.com/content/cloudera-content/cloudera-docs/Impala/latest/Installing-and-Using-Impala/ciiu_tutorial.html)


Create sample data and add it to hdfs

```bash
$ {  
printf "1,true,123.123,2012-10-24 08:55:00 
2,false,1243.5,2012-10-25 13:40:00
3,false,24453.325,2008-08-22 09:33:21.123
4,false,243423.325,2007-05-12 22:32:21.33454
5,true,243.325,1953-04-22 09:11:33" 
} > tab1.csv
$ {
printf "1,true,12789.123
2,false,1243.5
3,false,24453.325
4,false,2423.3254
5,true,243.325
60,false,243565423.325
70,true,243.325
80,false,243423.325
90,true,243.325"
} > tab2.csv
$ hadoop fs -mkdir /tmp/impala_test/tab1
$ hadoop fs -mkdir /tmp/impala_test/tab2
$ hadoop fs -put tab1.csv /tmp/impala_test/tab1/tab1.csv
$ hadoop fs -put tab2.csv /tmp/impala_test/tab2/tab2.csv
$ hadoop fs -lsr /tmp/
lsr: DEPRECATED: Please use 'ls -R' instead.
drwxr-xr-x   - bigdata supergroup          0 2014-01-17 15:54 /tmp/impala_test
drwxr-xr-x   - bigdata supergroup          0 2014-01-17 16:10 /tmp/impala_test/tab1
-rw-r--r--   1 bigdata supergroup        191 2014-01-17 15:54 /tmp/impala_test/tab1/tab1.csv
drwxr-xr-x   - bigdata supergroup          0 2014-01-17 16:09 /tmp/impala_test/tab2
-rw-r--r--   1 bigdata supergroup        157 2014-01-17 16:09 /tmp/impala_test/tab2/tab2.csv
```

Run the impala shell

```
$ impala-shell
Starting Impala Shell without Kerberos authentication
Connected to xdata:21000
Server version: impalad version 1.2.3 RELEASE (build 1cab04cdb88968a963a8ad6121a2e72a3a623eca)
Welcome to the Impala shell. Press TAB twice to see a list of available commands.

Copyright (c) 2012 Cloudera, Inc. All rights reserved.

(Shell build version: Impala Shell v1.2.3 (1cab04c) built on Fri Dec 20 19:39:39 PST 2013)
[xdata:21000] > DROP TABLE IF EXISTS tab1;
Query: drop TABLE IF EXISTS tab1
[xdata:21000] > CREATE EXTERNAL TABLE tab1
              > (
              >    id INT,
              >    col_1 BOOLEAN,
              >    col_2 DOUBLE,
              >    col_3 TIMESTAMP
              > );
Query: create EXTERNAL TABLE tab1 ( id INT, col_1 BOOLEAN, col_2 DOUBLE, col_3 TIMESTAMP )

Returned 0 row(s) in 3.88s
[xdata:21000] > CREATE EXTERNAL TABLE tab1
              > (
              >    id INT,
              >    col_1 BOOLEAN,
              >    col_2 DOUBLE,
              >    col_3 TIMESTAMP
              > )
              > ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
              > LOCATION '/tmp/impala_test/tab1';
Query: create EXTERNAL TABLE tab1 ( id INT, col_1 BOOLEAN, col_2 DOUBLE, col_3 TIMESTAMP ) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/tmp/impala_test/tab1'

Returned 0 row(s) in 2.48s
[xdata:21000] > DROP TABLE IF EXISTS tab2;
Query: drop TABLE IF EXISTS tab2
[xdata:21000] > CREATE EXTERNAL TABLE tab2
              > (
              >    id INT,
              >    col_1 BOOLEAN,
              >    col_2 DOUBLE
              > )
              > ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
              > LOCATION '/tmp/impala_test/tab2';
Query: create EXTERNAL TABLE tab2 ( id INT, col_1 BOOLEAN, col_2 DOUBLE ) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/tmp/impala_test/tab2'

Returned 0 row(s) in 2.14s
[xdata:21000] > select * from tab1;
Query: select * from tab1
+----+-------+------------+-------------------------------+
| id | col_1 | col_2      | col_3                         |
+----+-------+------------+-------------------------------+
| 1  | true  | 123.123    | 2012-10-24 08:55:00           |
| 2  | false | 1243.5     | 2012-10-25 13:40:00           |
| 3  | false | 24453.325  | 2008-08-22 09:33:21.123000000 |
| 4  | false | 243423.325 | 2007-05-12 22:32:21.334540000 |
| 5  | true  | 243.325    | 1953-04-22 09:11:33           |
+----+-------+------------+-------------------------------+
Returned 5 row(s) in 0.22s
[xdata:21000] > select * from tab2;
Query: select * from tab2
+----+-------+---------------+
| id | col_1 | col_2         |
+----+-------+---------------+
| 1  | true  | 12789.123     |
| 2  | false | 1243.5        |
| 3  | false | 24453.325     |
| 4  | false | 2423.3254     |
| 5  | true  | 243.325       |
| 60 | false | 243565423.325 |
| 70 | true  | 243.325       |
| 80 | false | 243423.325    |
| 90 | true  | 243.325       |
+----+-------+---------------+
Returned 9 row(s) in 0.24s
[xdata:21000] > DROP TABLE IF EXISTS tab3;
Query: drop TABLE IF EXISTS tab3
[xdata:21000] > CREATE TABLE tab3
              > (
              >    id INT,
              >    col_1 BOOLEAN,
              >    col_2 DOUBLE,
              >    month INT,
              >    day INT
              > )
              > ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
Query: create TABLE tab3 ( id INT, col_1 BOOLEAN, col_2 DOUBLE, month INT, day INT ) ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

Returned 0 row(s) in 2.12s
[xdata:21000] > show databases;
Query: show databases
+---------+
| name    |
+---------+
| default |
+---------+
Returned 1 row(s) in 0.12s
[xdata:21000] > use default;
Query: use default
[xdata:21000] > show tables;
Query: show tables
+------+
| name |
+------+
| tab1 |
| tab2 |
| tab3 |
+------+
Returned 3 row(s) in 0.12s
[xdata:21000] > describe tab1;
Query: describe tab1
+-------+-----------+---------+
| name  | type      | comment |
+-------+-----------+---------+
| id    | int       |         |
| col_1 | boolean   |         |
| col_2 | double    |         |
| col_3 | timestamp |         |
+-------+-----------+---------+
Returned 4 row(s) in 0.14s
[xdata:21000] > SELECT tab1.col_1, MAX(tab2.col_2), MIN(tab2.col_2)
              > FROM tab2 JOIN tab1 USING (id)
              > GROUP BY col_1 ORDER BY 1 LIMIT 5;
Query: select tab1.col_1, MAX(tab2.col_2), MIN(tab2.col_2) FROM tab2 JOIN tab1 USING (id) GROUP BY col_1 ORDER BY 1 LIMIT 5
+-------+-----------------+-----------------+
| col_1 | max(tab2.col_2) | min(tab2.col_2) |
+-------+-----------------+-----------------+
| false | 24453.325       | 1243.5          |
| true  | 12789.123       | 243.325         |
+-------+-----------------+-----------------+
Returned 2 row(s) in 0.50s
[xdata:21000] > SELECT tab2.*
              > FROM tab2,
              > (SELECT tab1.col_1, MAX(tab2.col_2) AS max_col2
              >  FROM tab2, tab1
              >  WHERE tab1.id = tab2.id
              >  GROUP BY col_1) subquery1
              > WHERE subquery1.max_col2 = tab2.col_2;
Query: select tab2.* FROM tab2, (SELECT tab1.col_1, MAX(tab2.col_2) AS max_col2 FROM tab2, tab1 WHERE tab1.id = tab2.id GROUP BY col_1) subquery1 WHERE subquery1.max_col2 = tab2.col_2
+----+-------+-----------+
| id | col_1 | col_2     |
+----+-------+-----------+
| 1  | true  | 12789.123 |
| 3  | false | 24453.325 |
+----+-------+-----------+
Returned 2 row(s) in 0.59s
[xdata:21000] > INSERT OVERWRITE TABLE tab3
              > SELECT id, col_1, col_2, MONTH(col_3), DAYOFMONTH(col_3)
              > FROM tab1 WHERE YEAR(col_3) = 2012;
Query: insert OVERWRITE TABLE tab3 SELECT id, col_1, col_2, MONTH(col_3), DAYOFMONTH(col_3) FROM tab1 WHERE YEAR(col_3) = 2012
Inserted 2 rows in 1.29s
[xdata:21000] > SELECT * FROM tab3;
Query: select * FROM tab3
+----+-------+---------+-------+-----+
| id | col_1 | col_2   | month | day |
+----+-------+---------+-------+-----+
| 1  | true  | 123.123 | 10    | 24  |
| 2  | false | 1243.5  | 10    | 25  |
+----+-------+---------+-------+-----+
Returned 2 row(s) in 0.26s
[xdata:21000] >
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