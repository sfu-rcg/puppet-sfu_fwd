require 'puppet'

module Puppet::Parser::Functions
  newfunction(:generate_firewalld_richrules, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    Accepts a firewalld::zone hash with rich_rules and Converts the array of rich rules\' source and destination address values 
    as well as services to separate rich rules and injects them 
    back into the firewalld::zone hash so that they are valid(Can only have one source address per rich rule. 
    Used while building rules in the firewalld::zone module/manifest

    For example:

        $completedhash = generate_firewalld_richrules($firewalld_zone_hash)
        create_resources($completedhash)

    # INPUT ERROR CHECKING
    if args.length > 1
      raise Puppet::ParseError, ("generate_resource_hash(): wrong number of args (#{args.length}; must be no more than 1 parent hash)")
    end
    
    my_array = args[0][key]
    unless my_array.is_a?(Hash)
      raise(Puppet::ParseError, 'generate_resource_hash(): first arg must be a hash')
    end
    # INPUT ERROR CHECKING DONE


    # Return the new hash
    # finalhash
    ENDHEREDOC

    newhash = Hash.new
    finalhash = Hash.new
    args[0].each do |key, value|
      # INPUT ERROR CHECKING
      if args.length > 1
        raise Puppet::ParseError, ("generate_resource_hash(): wrong number of args (#{args.length}; must be no more than 1 parent hash)")
      end

      my_array = args[0][key]
      unless my_array.is_a?(Hash)
        raise(Puppet::ParseError, 'generate_resource_hash(): first arg must be a hash')
      end
      # INPUT ERROR CHECKING DONE



      orighash = args[0][key]
      newhash = orighash.dup.delete_if {|key,value| key == 'rich_rules'}
      address_array_of_hashes = []
      temphash = Hash.new
      orighash['rich_rules'].each do |rich_rules|
        if rich_rules.kind_of?(Array)
          rich_rules.each do |rich_rules|
            address_array_of_hashes << check_rule(rich_rules, address_array_of_hashes)
          end
        else
          address_array_of_hashes << check_rule(rich_rules, address_array_of_hashes)
        end
            temphash = { "rich_rules" => address_array_of_hashes.flatten }
            newhash = newhash.merge(temphash)
      end

      finalhash = { key => newhash }

    end
    return finalhash


  end

end

def check_rule(rich_rules, address_array_of_hashes)
  addresscleanhash = deep_copy(rich_rules)
  servicehash = Hash.new
  temphash = Hash.new
  address_and_servicehash_array = []
  source_array_of_hashes = []
  destination_array_of_hashes = []
  service_array_of_hashes = []
  address_array_of_hashes = []
  if rich_rules.key?('source')
    if rich_rules['source']['address'].kind_of?(Array) 
      addresscleanhash['source'].delete('address')
      rich_rules['source']['address'].each do |source_address|
        source_addresshash = { "source" => { "address" => source_address } }
        source_array_of_hashes << source_addresshash
      end
    end
  end
  if rich_rules.key?('destination')
    if rich_rules['destination']['address'].kind_of?(Array) 
      addresscleanhash['destination'].delete('address')
      rich_rules['destination']['address'].each do |destination_address|
        destination_addresshash = { "destination" => { "address" => destination_address } }
        destination_array_of_hashes << destination_addresshash
      end
    end
  end
  if rich_rules.key?('service')
    if rich_rules['service'].kind_of?(Array)
      addresscleanhash.delete('service')
      rich_rules['service'].each do |service|
        servicehash = { "service" => service }
        service_array_of_hashes << servicehash
      end
    end
  end
  address_and_servicehash_array.add_to_array(source_array_of_hashes)
  address_and_servicehash_array.add_to_array(destination_array_of_hashes)
  address_and_servicehash_array.add_to_array(service_array_of_hashes)

  producthash = address_and_servicehash_array[0].product(*address_and_servicehash_array[1..address_and_servicehash_array.count])

  producthash.each_with_index do |arr_hash, index|
    temphash = temphash.create_hash(producthash[index])
    temphash = temphash.deep_merge(addresscleanhash)
    address_array_of_hashes << temphash
  end
  return address_array_of_hashes


end

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

class ::Hash
  def deep_merge(second)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    self.merge(second, &merger)
  end
  def create_hash(hs)
    hs.reduce(:merge)
  end
end
class Array
  def add_to_array(array)
    array.size > 0 ? self.push(array) : self
  end
end
