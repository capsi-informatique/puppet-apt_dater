# apt_dater

Manage the `apt-dater` and `apt-dater-host` package and configuration files.

## Table of Contents

1. [Description](#description)
1. [What apt_dater affects](#what-apt_dater-affects)
1. [Usage](#usage)
   * [Managed Nodes](#managed-nodes)
   * [Central Node](#central-node)
1. [Limitations - OS compatibility, etc.](#limitations)

## Description

Briefly tell users why they might want to use your module. Explain what your
module does and what kind of problems users can solve with it.

This should be a fairly short description helps the user decide if your module
is what they want.

## What apt_dater affects

This module install `apt-dater-host` on managed Debian machines and `apt-dater` on a central node to perform update from
a single point.

## Usage

### Managed nodes

On managed node you can export the host to the central node via the Puppet Store Config functionality.

You can export the host yourself with de defined type `apt_dater::host` or let the module do it for you:

```puppet
class { 'apt_dater':
  ensure        => 'present',
  export_host   => true,
  export_config => {
     user  => 'update_user',
     group => 'Databases',
  },
  collect_tag  => 'production', 
}
```

### Central node

To collect all exported nodes on the central update node, you can use this:

```puppet
class { 'apt_dater':
  ensure         => 'present',
  export_host    => true,
  export_config  => {
     user  => 'root',
     host  => 'localhost',
     group => 'Management',
  },
  collect_hosts => true,
  collect_tag   => 'production', 
}
```

## Limitations

Only Debian-like operating systems are supported as apt-dater is tied to aptitude/apt package manager. 
