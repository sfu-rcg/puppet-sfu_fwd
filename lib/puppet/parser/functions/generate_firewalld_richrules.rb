require 'puppet'
module Puppet::Parser::Functions
  newfunction(:generate_firewalld_richrules, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    Accepts a firewalld::zone hash with rich_rules and Converts the array of rich rules\' address values to separate rich rules and injects them 
    back into the firewalld::zone hash so that they are valid(Can only have one source address per rich rule. 
    Used while building rules in the firewalld::zone module/manifest

    For example:

        $my_array = ['one','two']
        $my_hash = generate_resource_hash($my_array,'foo','bar')
        # The resulting hash is equivalent to:
        # $my_hash = {
        #   'bar1' => {
        #     'foo' => 'one'
        #   }
        #   'bar2' => {
        #     'foo' => 'two'
        #   }
        # }
        create_resources(foobar,$my_hash)

    ENDHEREDOC

#    if args.length < 2
#      raise Puppet::ParseError, ("generate_resource_hash(): wrong number of args (#{args.length}; must be at least 2)")
#    end
#
#    my_array = args[0]
#    unless my_array.is_a?(Array)
#      raise(Puppet::ParseError, 'generate_resource_hash(): first arg must be an array')
#    end
#
#    param = args[1]
#    unless param.is_a?(String)
#      raise(Puppet::ParseError, 'generate_resource_hash(): second arg must be a string')
#    end
#
#    prefix = args[2] if args[2]
#    if prefix
#      unless prefix.is_a?(String)
#        raise(Puppet::ParseError, 'generate_resource_hash(): third arg must be a string')
#      end
#    end
#
#    # The destination hash we'll be filling.
#    generated = Hash.new
#    pos = 1
#
#    my_array.each do |value|
#      id = prefix + pos.to_s
#      generated[id] = Hash.new
#      generated[id][param] = value
#      pos = pos + 1
#    end
#
#    # Return the new hash
#    generated

    newhash = Hash.new
    finalhash = Hash.new
    args[0].each do |key, value|
      orighash = args[0][key]
      newhash = function_delete( [ orighash, 'rich_rules' ] )

      address_array_of_hashes = []
      temphash = Hash.new
      
      orighash['rich_rules'].each do |rich_rules|

        if rich_rules.key?('source')
          if rich_rules['source']['address'].kind_of?(Array)
            addresscleanhash = deep_copy(rich_rules)
            addresscleanhash['source'].delete('address')
            
            array_of_addresses = []
            rich_rules['source']['address'].each do |address|
              addresshash = { "source" => { "address" => address } }
              merged_addresshash = addresshash.deep_merge(addresscleanhash) 

              address_array_of_hashes << merged_addresshash 
              
            end
            temphash = { "rich_rules" => address_array_of_hashes }
            newhash = function_merge( [ newhash, temphash ] )
          end
        end
        if rich_rules.key?('destination')
          if rich_rules['destination']['address'].kind_of?(Array)
            addresscleanhash = deep_copy(rich_rules)
            addresscleanhash['destination'].delete('address')
            
            array_of_addresses = []
            rich_rules['destination']['address'].each do |address|
              addresshash = { "destination" => { "address" => address } }
              merged_addresshash = addresshash.deep_merge(addresscleanhash) 

              address_array_of_hashes << merged_addresshash 
              
            end
            temphash = { "rich_rules" => address_array_of_hashes }
            newhash = function_merge( [ newhash, temphash ] )
          end
        end
      end

      finalhash = { key => newhash }
    end

    finalhash


  end

end

def deep_copy(o)
    Marshal.load(Marshal.dump(o))
end

class ::Hash
  def deep_merge(second)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    self.merge(second, &merger)
  end
end
