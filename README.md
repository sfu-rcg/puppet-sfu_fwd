# sfu_fwd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sfu_fwd](#setup)
    * [What sfu_fwd affects](#what-sfu_fwd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sfu_fwd](#beginning-with-sfu_fwd)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Built with Puppet 3.x in mind and CentOS 6 & 7.
This module is to provide a framework as well as baseline for managing FirewallD firewalls and possibly some tcpwrapper links
It also supports defining these details inside of the Foreman

## Module Description

This will setup management of your Linux Firewall and allow easy management of the base as well as adding custom rules

## Setup

```puppet
  include sfu_fwd::basefirewall  # to receive the default pre and post values(Allow defaults, deny remaining unspecified)
  class { 'sfu_fwd::customfirewall':
    # <FIREWALL HASH> (see puppetlabs-firewall module for hash details)
  }
  # If you want to utilize the ssh allow rules based of some specialized trusted hosts list method (see class for details)
  class { 'sfu_fwd::ssh':
    public => (true|false),
  }
```

### What sfu_fwd affects

* FirewallD
* IPTables
* TCPWrappers in some circumstances

### Setup Requirements 

sfu-rcg/puppet-firewalld module must be installed in the environment

### Beginning with sfu_fwd

Refer to Setup [above](#setup)
(For an extra example of hashes for customfirewall, see https://github.com/sfu-rcg/puppet-firewalld).

## Limitations

Requires: sfu-rcg/puppet-firewalld

## Development

We'd love to get contributions from you!
We're always curious how we can make this more functional and modular for everyone's greater good in systems' automation

License
-------

See LICENSE.md file.

Support
-------

There is no expectation of support for this module but we will in all attempts work on maintaining it to support our wide uses of linux
