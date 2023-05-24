# @summary Install and configure apt-dater
#
# @param ensure              Should apt-dater and apt-dater-host be installed?
# @param manage_tmux_package Sould this class install tmux
# @param export_host         Do i need to export this host to be collected?
# @param export_config       The attribute to pass to the exported host
# @param config_host_path    The config file to save the host list
# @param config_path         The config file of apt-dater central node
# @param collect_hosts       Should we collect all exported hosts?
# @param collect_tag         The tag to use for the export and the collect
# @param spawn_agent         Do apt-dater need to spawn his own agent?
#
# @example
#   include apt_dater
class apt_dater (
  Enum['present', 'absent'] $ensure              = 'present',
  Boolean                   $manage_tmux_package = true,
  Boolean                   $export_host         = true,
  Hash[String, Any]         $export_config       = {},
  Stdlib::Unixpath          $config_host_path    = '/etc/apt-dater/hosts.xml',
  Stdlib::Unixpath          $config_path         = '/etc/apt-dater/apt-dater.xml',
  Boolean                   $collect_hosts       = false,
  String                    $collect_tag         = 'default',
  Boolean                   $spawn_agent         = false,
) {
  if $manage_tmux_package and $ensure == 'present' {
    package { 'tmux':
      ensure => 'present',
    }
  }

  $dater_ensure = bool2str($collect_hosts, $ensure, 'absent')
  package { 'apt-dater':
    ensure => $dater_ensure,
  }

  package { 'apt-dater-host':
    ensure => $ensure,
  }

  if $export_host and $ensure == 'present' {
    @@apt_dater::host { $facts['networking']['fqdn']:
      * => {
        host => $facts['networking']['fqdn'],
        user => 'root',
        tag  => [$collect_tag],
      } + $export_config,
    }
  }

  if $dater_ensure == 'present' {
    xml_fragment { "${config_path}:ssh":
      ensure  => $ensure,
      path    => $config_path,
      xpath   => '/apt-dater/ssh',
      purge   => true,
      content => {
        attributes => {
          'spawn-agent' => bool2str($spawn_agent, 'true', 'false'),
        },
      },
      require => [
        Package['apt-dater'],
      ],
    }

    xml_fragment { "${config_host_path}:Hosts":
      ensure  => $ensure,
      path    => $config_host_path,
      xpath   => '/hosts',
      purge   => true,
      require => [
        Package['apt-dater'],
      ],
    }
    -> Apt_dater::Hostgroup <<| tag == $collect_tag |>>
    -> Apt_dater::Host <<| tag == $collect_tag |>>
  }
}
