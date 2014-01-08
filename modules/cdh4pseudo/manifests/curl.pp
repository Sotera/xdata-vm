# Class: cmantix/cdh4pseudo::curl
#
# Install curl ... dont ask me why this is not standard on servers ... I ALWAYS use it
#
# Parameters:
#   
# Actions:
#     install curl
# Requires:
#     
# Sample Usage:
#     include cdh4pseudo::curl
#
class cdh4pseudo::curl {
  if ! defined(Package['curl']) {
    package { 'curl':
      ensure => 'present',
    }
  }
}