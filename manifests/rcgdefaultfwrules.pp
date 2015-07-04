class sfu_fwd::rcgdefaultfwrules($trustedIPs_nfs = undef, $trustedIPs_rshd = undef, $trustedIPs_5555 = undef) {
  firewalld::service { 'rshd':
    short       => 'rshd',
    description => 'Remote Shell.',
    ports       => [
      { port => '514', protocol => 'tcp' },
    ],
  }
  firewalld::service { 'DataProtector':
    short       => 'DataProtector',
    description => 'Data Protector service.',
    ports       => [
      { port => '5555', protocol => 'tcp' },
    ],
  }

  if $trustedIPs_5555 {
    $dataprotector =
    {
      family      => 'ipv4',
      source      => {
        address     => $trustedIPs_5555,
      },
      service     => 'DataProtector',
      action      => {
        action_type => 'accept',
      },
    }
  }
  if $trustedIPs_rshd {
    $rshd = 
    {
      family      => 'ipv4',
      source      => {
        address     => $trustedIPs_rshd,
      },
      service     => 'rshd',
      action      => {
        action_type => 'accept',
      },
    }
  }
  if $trustedIPs_nfs {
    $nfs =
    [
      {
        family      => 'ipv4',
        source      => {
          address     => $trustedIPs_nfs,
        },
        service     => [ 'ssh', 'vnc-server', 'nfs', 'mountd', 'rpc-bind', ],
        action      => {
          action_type => 'accept',
        },
      },
    ]
  }

#  if $trustedIPs_nfs {
#    $nfs =
#    [
#    {
#      family      => 'ipv4',
#      source      => {
#        address     => $trustedIPs_nfs,
#      },
#      service     => 'ssh',
#      action      => {
#        action_type => 'accept',
#      },
#    },
#    {
#      family      => 'ipv4',
#      source      => {
#        address     => $trustedIPs_nfs,
#      },
#      service     => 'vnc-server',
#      action      => {
#        action_type => 'accept',
#      },
#    },
#    {
#      family      => 'ipv4',
#      source      => {
#        address     => $trustedIPs_nfs,
#      },
#      service     => 'nfs',
#      action      => {
#        action_type => 'accept',
#      },
#    },
#    {
#      family      => 'ipv4',
#      source      => {
#        address     => $trustedIPs_nfs,
#      },
#      service     => 'mountd',
#      action      => {
#        action_type => 'accept',
#      },
#    },
#    {
#      family      => 'ipv4',
#      source      => {
#        address     => $trustedIPs_nfs,
#      },
#      service     => 'rpc-bind',
#      action      => {
#        action_type => 'accept',
#      },
#    },
#    ]
#  }


 class { 'sfu_fwd::customzone':
    firewallhash => {
      'rcgzone' => {
        short       => 'rcgzone',
        description => 'This is a test zone for RCG.',
        rich_rules  => [
          $dataprotector,
          $rshd,
          $nfs,
        ],
      }
    }
  }

}
