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

#  stage { 'setup': 
#	before => Stage['main'],
# }

# exec {'cdh_update':
#   command => '/usr/bin/apt-get update',
#   require => Class['cdh4pseudo::source'],
# }

#  class {'cdh4pseudo::curl': stage => setup}  
#  class {'cdh4pseudo::source': stage => setup, require => Class['cdh4pseudo::curl']}
#  class {'cdh4pseudo::java': require => Exec['cdh_update']}
#  class {'cdh4pseudo::pseudo': require => Class['cdh4pseudo::java']}
#  class {'cdh4pseudo::impala': require => [Class['cdh4pseudo::source'],Class['cdh4pseudo::hive']] }
 
 
  include cdh4pseudo::pseudo
  include cdh4pseudo::hbase
  include cdh4pseudo::hive
  include cdh4pseudo::impala
}