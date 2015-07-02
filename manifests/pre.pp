class sfu_fwd::pre {
	 # Default firewall rules
	firewall { '000 accept all icmp':
		proto   => 'icmp',
		action  => 'accept',
	}->
	firewall { '001 accept all to lo interface':
		proto   => 'all',
		iniface => 'lo',
		action  => 'accept',
	}->
	firewall { "002 reject local traffic not on loopback interface":
		iniface     => '! lo',
		proto       => 'all',
		destination => '127.0.0.1/8',
		action      => 'reject',
	}
	firewall { '003 accept related established rules':
		proto   => 'all',
		state   => ['RELATED', 'ESTABLISHED'],
		action  => 'accept',
	}
  # Following section of SSH trusted list is only to be used during testing as we will be implementing another puppet manifest to check for trusted hosts and apply ssh rules via that
	firewall { '004 accept ssh from trusted RCG network':
		proto   => 'tcp',
    source  => '199.60.0.0/22',
    dport   => '22',
		state   => ['NEW', 'ESTABLISHED'],
		action  => 'accept',
	}
}
