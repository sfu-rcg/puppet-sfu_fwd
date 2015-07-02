# This allows the submission of a firewall hash that contains an array of source values inside of a single rich rule
# the backend generate_firewalld_richrules parser will then separate them into a rich_rule per source IP for you
# and then submit the returned parsed hash to the create_resources

class sfu_fwd::customzone($firewallhash = {}) {
  $completedhash = generate_firewalld_richrules($firewallhash) 
  create_resources('::firewalld::zone', $completedhash)
}

