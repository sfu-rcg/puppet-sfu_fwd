# This defined type is so that we can call firewalld::rich_rules while maintaining our `generate_firewalld_richrules` function, functionality
# which allows us to put in an array of source addresses and services in rules and have it create a rule to match all permutations of it.
define sfu_fwd::customrule_define($firewallhash = {}) {
  $completedhash = generate_firewalld_richrules($firewallhash)
  create_resources('::firewalld::rich_rule', $completedhash)
}
