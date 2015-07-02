# Plan is to have this module utilize sourcing another module via collector and tags to pull in values for trusted networks
# If $public is set to true we will still source the trusted networks and create the rules as well as adding allow all SSH
# as this will allow us to choose to do rate limiting and other options against untrusted networks.
class sfu_fw::ssh(
  $public     = false,
  $trustedIPs = undef,
  ) {

  $filternum   = '022'
  $servicename = 'SSH'
  $dport       = 22
  $sport       = undef
  $proto       = 'tcp'
  if ($trustedIPs) and ($trustedIPs != []) and (!$public) {
    sfu_fw::sourceip::simpleloop { "SSH Name-unused but must be dynamic-Private":
      trustedIPs  => $trustedIPs,
      filternum   => $filternum,
      servicename => $servicename,
      proto       => $proto,
      dport       => $dport,
      sport       => $sport,
    }
  }
  elsif $public {
    sfu_fw::sourceip::simpleloop { "SSH Name-unused but must be dynamic-Public":
      trustedIPs  => [ '0.0.0.0' ],
      filternum   => $filternum,
      servicename => $servicename,
      proto       => $proto,
      dport       => $dport,
      sport       => $sport,
    }
  }
  else {
    fail("You've chosen to make this host not public but failed to include trusted hosts for SSH")
  }
}
