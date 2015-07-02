define sfu_fwd::sourceip::simpleloop($filternum = '010', $servicename = undef, $trustedIPs = undef, $proto, $dport = undef, $sport = undef) {

  if $trustedIPs {
    validate_array($trustedIPs)
    validate_re($filternum, '^[0-9]{3}$', 'Your filternum has to contain a number from 000 to 999 as it is used to organize IPTables rules')
    validate_re($proto,'^[a-zA-Z0-9]+$', 'Apply a proper protocol name to val $proto')
    unless $trustedIPs == [] {
      $suffix_trustedIPs = suffix($trustedIPs, " ${servicename}${proto}${filternum}")
      sfu_fwd::sourceip::simpleloopd { $suffix_trustedIPs:
        filternum   => $filternum,
        servicename => $servicename,
        proto       => $proto,
        dport       => $dport,
        sport       => $sport,
      }
    }
  }
}
