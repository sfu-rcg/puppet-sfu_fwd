class sfu_fwd::basefirewall {
  Firewall {
    before  => Class['sfu_fwd::post'],
    require => Class['sfu_fwd::pre'],
  }
  class { ['sfu_fwd::pre', 'sfu_fwd::post']: }
}
