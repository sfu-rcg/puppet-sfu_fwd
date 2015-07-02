# == Class: sfu_fwd
#
# Full description of class sfu_fwd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'sfu_fwd':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class sfu_fwd {
  resources { "firewall":
    purge => true
  }
/*
  Firewall {
    before  => Class['sfu_fwd::post'],
    require => Class['sfu_fwd::pre'],
  }
  class { ['sfu_fwd::pre', 'sfu_fwd::post']: }
*/
  #class { ['sfu_fwd::pre', 'sfu_fwd::rcgdefaultfwrules', 'sfu_fwd::post']: }
  /* class { 'firewall': } */

}
include sfu_fwd
