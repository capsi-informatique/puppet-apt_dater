# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`apt_dater`](#apt_dater): Install and configure apt-dater

### Defined types

* [`apt_dater::host`](#apt_daterhost): Configure a host in apt-dater
* [`apt_dater::hostgroup`](#apt_daterhostgroup): Group host

## Classes

### <a name="apt_dater"></a>`apt_dater`

Install and configure apt-dater

#### Examples

##### 

```puppet
include apt_dater
```

#### Parameters

The following parameters are available in the `apt_dater` class:

* [`ensure`](#ensure)
* [`manage_tmux_package`](#manage_tmux_package)
* [`export_host`](#export_host)
* [`export_config`](#export_config)
* [`config_host_path`](#config_host_path)
* [`config_path`](#config_path)
* [`collect_hosts`](#collect_hosts)
* [`collect_tag`](#collect_tag)
* [`spawn_agent`](#spawn_agent)

##### <a name="ensure"></a>`ensure`

Data type: `Enum['present', 'absent']`

Should apt-dater and apt-dater-host be installed?

Default value: `'present'`

##### <a name="manage_tmux_package"></a>`manage_tmux_package`

Data type: `Boolean`

Sould this class install tmux

Default value: ``true``

##### <a name="export_host"></a>`export_host`

Data type: `Boolean`

Do i need to export this host to be collected?

Default value: ``true``

##### <a name="export_config"></a>`export_config`

Data type: `Hash[String, Any]`

The attribute to pass to the exported host

Default value: `{}`

##### <a name="config_host_path"></a>`config_host_path`

Data type: `Stdlib::Unixpath`

The config file to save the host list

Default value: `'/etc/apt-dater/hosts.xml'`

##### <a name="config_path"></a>`config_path`

Data type: `Stdlib::Unixpath`

The config file of apt-dater central node

Default value: `'/etc/apt-dater/apt-dater.xml'`

##### <a name="collect_hosts"></a>`collect_hosts`

Data type: `Boolean`

Should we collect all exported hosts?

Default value: ``false``

##### <a name="collect_tag"></a>`collect_tag`

Data type: `String`

The tag to use for the export and the collect

Default value: `'default'`

##### <a name="spawn_agent"></a>`spawn_agent`

Data type: `Boolean`

Do apt-dater need to spawn his own agent?

Default value: ``false``

## Defined types

### <a name="apt_daterhost"></a>`apt_dater::host`

Configure a host in apt-dater

#### Examples

##### 

```puppet
apt_dater::host { 'namevar':
  host => 'myserver.mycompany.lan',
  user => 'root',
}
```

#### Parameters

The following parameters are available in the `apt_dater::host` defined type:

* [`user`](#user)
* [`host`](#host)
* [`group`](#group)
* [`ensure`](#ensure)
* [`comment`](#comment)
* [`type`](#type)
* [`port`](#port)
* [`identity`](#identity)

##### <a name="user"></a>`user`

Data type: `String`

Username used for the SSH connection

##### <a name="host"></a>`host`

Data type: `String`

Hostname or IP used for the connection

##### <a name="group"></a>`group`

Data type: `String[1]`

Group of this host

Default value: `'Default Group'`

##### <a name="ensure"></a>`ensure`

Data type: `Enum['present', 'absent']`

Should this host be present

Default value: `'present'`

##### <a name="comment"></a>`comment`

Data type: `Optional[String[1]]`

Comment for this host dicplayed in apt-dater

Default value: ``undef``

##### <a name="type"></a>`type`

Data type: `String[1]`

Connection type

Default value: `'generic-ssh'`

##### <a name="port"></a>`port`

Data type: `Integer[1, 65535]`

SSH Port

Default value: `22`

##### <a name="identity"></a>`identity`

Data type: `Optional[Stdlib::Unixpath]`

Identity file to use

Default value: ``undef``

### <a name="apt_daterhostgroup"></a>`apt_dater::hostgroup`

Group host

#### Examples

##### 

```puppet
apt_dater::hostgroup { 'Internal Hosts': }
```

#### Parameters

The following parameters are available in the `apt_dater::hostgroup` defined type:

* [`user`](#user)

##### <a name="user"></a>`user`

Data type: `Optional[String[1]]`

the default user of this group

Default value: ``undef``
