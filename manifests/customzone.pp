class sfu_fwd::customzone($firewallhash = {}) {

  $completedhash = generate_firewalld_richrules($firewallhash) 
  #notify { "${completedhash}": }

  create_resources('::firewalld::zone', $completedhash)

#  $firewall_empty = undef
#  #$firewallhash_int = delete({"target"=>"DROP", "short"=>"rcgzone", "description"=>"This is a test zone for RCG.", "services"=>["ssh", "vnc-server"]},'target')
#  $firewallhash_int = delete($firewallhash['rcgzone'],'rich_rules')
#  #notify { $firewallhash['rcgzone']: }
#  #notify { $firewallhash_int: }
#  #notify { $firewallhash['rcgzone']['rich_rules'][0]['source']['address']: }
#  sfu_fwd::customzone::loop_rich { $firewallhash['rcgzone']['rich_rules']: firewallhash => $firewallhash_int }
#  define sfu_fwd::customzone::loop_rich($firewallhash) {
#    sfu_fwd::customzone::loop_source { $name['source']: firewallhash => $firewallhash, rich_rule => $name }
#  }
#  define sfu_fwd::customzone::loop_source($firewallhash, $rich_rule) {
#    #$suffix_name = suffix("Source is: ", $name)
#    #notify { $name: }
#    if is_array($name['address']) {
#      sfu_fwd::customzone::loop_source_address { $name['address']: firewallhash => $firewallhash, rich_rule => $rich_rule }
#    }
#    #notify { "Hash is: ${firewallhash}": }
#    $chunkfirewallhash = { 
#      'rcgzone' => {
#        rich_rules => [
#          {
#            source   => { 
#              address  => $name,
#            }
#          }
#        ]
#      }
#    }
#    $sfu_fwd::customzone::firewall_empty = merge($firewallhash, $chunkfirewallhash)
#    #notify { $rich_rule: }
#   # notify { $newfirewallhash: }
#    #notify { "${sfu_fwd::customzone::firewallhash_int}": }
#  }
#  define sfu_fwd::customzone::loop_source_address($firewallhash, $rich_rule) {
#    notify { "Source is: ${name}": }
#    #$firewallhash['rcgzone']['rich_rules']["${rich_rule}"]['source']['address'] 
#
#    #firewallhash => { 
#    #  $firewallhash['rcgzone'] => {
#    #    rich_rules => [
#    #      {
#    #        $firewallhash['rcgzone']['rich_rules']["${rich_rule}"] => 
#  }
#
#  #create_resources('::firewalld::zone', $firewallhash)
}

