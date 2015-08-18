# Foreman wrapper for firewalld::service
# This class is so that we can provide default service XML files, if requested(included),
# for the computer or hostgroup in the foreman.  We will manage the data in the foreman 
# without allowing override by users.

class sfu_fwd::rcg_default_services($servicehash = {}) {
  create_resources('::firewalld::service', $servicehash)
}

