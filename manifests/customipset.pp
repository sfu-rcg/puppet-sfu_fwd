# This file utilizes mighq/ipset 0.2.1 on forge.puppetlabs.com
# the purpose is for use in the foreman as it doesn't support defined types
class sfu_fwd::customipset($ipsethash = undef) {
  if $ipsethash and !empty($ipsethash) {
    create_resources('::ipset', $ipsethash)
  }
}
