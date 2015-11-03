# This allows the submission of a firewall hash that contains an array of source values inside of a single rich rule
# the backend generate_firewalld_richrules parser will then separate them into a rich_rule per source IP for you
# and then submit the returned parsed hash to the create_resources
#
# This defined type is so that we can call firewalld::rich_rules while maintaining our `generate_firewalld_richrules` function, functionality
# which allows us to put in an array of source addresses and services in rules and have it create a rule to match all permutations of it.
define sfu_fwd::customzone_define($firewallhash = {}) {
  $completedhash = generate_firewalld_richrules($firewallhash) 
  create_resources('::firewalld::zone', $completedhash)
}

