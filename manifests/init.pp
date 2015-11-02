class sfu_fwd (
  $enabled         = false,
  $default_zone    = 'public',
  $minimal_mark    = '100',
  $cleanup_on_exit = 'yes',
  $lockdown        = 'no',
  $ipv6_rpfilter   = 'yes',
) {
  if $enabled == true {
    include firewalld
    if $default_zone {
      class { 'firewalld::configuration':
        default_zone    => $default_zone,
        minimal_mark    => $minimal_mark,
        cleanup_on_exit => $cleanup_on_exit,
        lockdown        => $lockdown,
        ipv6_rpfilter   => $ipv6_rpfilter,
      }
    }
  }
}
