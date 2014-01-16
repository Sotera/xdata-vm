# Class: cmantix/cdh4pseudo
#
# Installs Cloudera CDH4:
#  * Hadoop Pseudo distributed mode
#  * Hbase pseudo distributed mode
#  * Zookeeper. 
#  * Hbase thrift
#  * Hbase Rest
#
# Parameters:
#   
# Actions:
#   Install base pacakages, validate operating system.
# Requires:
# 
# Sample Usage:
#     include cdh4pseudo
#

class cdh4pseudo {
 
  include cdh4pseudo::pseudo
  include cdh4pseudo::hbase
  include cdh4pseudo::hive
  include cdh4pseudo::impala
}