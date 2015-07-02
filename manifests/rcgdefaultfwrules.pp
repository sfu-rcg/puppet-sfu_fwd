class sfu_fwd::rcgdefaultfwrules($trustedIPs_nfs = undef, $trustedIPs_rshd = undef, $trustedIPs_5555 = undef) {

  define trust_these_IPs_rshd() {
    firewall { "004 accept rshd trusted IPs ${name}":
      proto   => 'tcp',
      dport   => '514',
      action  => 'accept',
      source  => $name, 
    }  
  }
/*  firewall { '005 deny all remaining untrusted to rshd':
    proto   => 'tcp',
    dport   => '514',
    action  => 'drop',
  }
*/  
  define trust_these_IPs_nfs_tcp() {
    firewall { "006 accept tcp NFS connections from these trusted IPs ${name}":
      proto   => 'tcp',
      action  => 'accept',
      source  => $name, 
      dport   => [ '111', '2049', '4001', '4002', '4003', '4004' ],
    }
  }  
  define trust_these_IPs_nfs_udp() {
    firewall { "007 accept udp NFS connections from these trusted IPs ${name}":
      proto   => 'udp',
      action  => 'accept',
      source  => $name, 
      dport   => [ '111', '2049', '4001', '4002', '4003', '4004' ],
    }
  }  
  define trust_these_5555() {
    firewall { "008 accept port 5555 from these trusted IPs ${name}":
      proto   => 'tcp',
      action  => 'accept',
      source  => $name, 
      dport   => '5555',
    }
  }  
  if $trustedIPs_nfs {
    validate_array($trustedIPs_nfs)
    unless $trustedIPs_nfs == [] {
      trust_these_IPs_nfs_tcp{$trustedIPs_nfs:}
      trust_these_IPs_nfs_udp{$trustedIPs_nfs:}
    }
  }
  if $trustedIPs_rshd {
    validate_array($trustedIPs_rshd)
    unless $trustedIPs_rshd == [] {
      trust_these_IPs_rshd{$trustedIPs_rshd:}
    }
  }
  if $trustedIPs_5555 {
    validate_array($trustedIPs_5555)
    unless $trustedIPs_5555 == [] {
      trust_these_5555{$trustedIPs_5555:}
    }
  }
}
