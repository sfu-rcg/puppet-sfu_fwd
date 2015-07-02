define sfu_fwd::sourceip::simpleloopd($filternum = '010', $servicename = undef, $proto, $dport = undef, $sport = undef) {
  $trustedIP = delete($name, " ${servicename}${proto}${filternum}")
  firewall { "${filternum} accept ${proto} ${servicename} connections from these trusted IPs ${trustedIP}":
    proto   => $proto,
    action  => 'accept',
    source  => $trustedIP,
    dport   => $dport,
    sport   => $sport,
  }
}
