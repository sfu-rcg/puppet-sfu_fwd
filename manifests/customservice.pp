# Foreman wrapper for firewalld::service

class sfu_fwd::customservice($servicehash = {}) {
  create_resources('::firewalld::service', $servicehash)
}

