# @summary Configure a host in apt-dater
#
# @param user     Username used for the SSH connection
# @param host     Hostname or IP used for the connection
# @param group    Group of this host
# @param ensure   Should this host be present
# @param comment  Comment for this host dicplayed in apt-dater
# @param type     Connection type
# @param port     SSH Port
# @param identity Identity file to use
#
# @example
#   apt_dater::host { 'namevar':
#     host => 'myserver.mycompany.lan',
#     user => 'root',
#   }
define apt_dater::host (
  String                     $user,
  String                     $host,
  String[1]                  $group    = 'Default Group',
  Enum['present', 'absent']  $ensure   = 'present',
  Optional[String[1]]        $comment  = undef,
  String[1]                  $type     = 'generic-ssh',
  Integer[1, 65535]          $port     = 22,
  Optional[Stdlib::Unixpath] $identity = undef
) {
  include apt_dater

  ensure_resource('apt_dater::hostgroup', $group, { tag => [$apt_dater::collect_tag] })

  xml_fragment { "${apt_dater::config_host_path}:Host - ${title}":
    ensure  => $ensure,
    path    => $apt_dater::config_host_path,
    xpath   => "/hosts/group[@name='${group}']/host[@name='${title}']",
    content => {
      attributes => {
        'name'     => $title,
        'comment'  => $comment,
        'type'     => $type,
        'ssh-user' => $user,
        'ssh-host' => $host,
        'ssh-port' => $port,
        'ssh-id'   => $identity,
      },
    },
    require => [
      Xml_fragment["${apt_dater::config_host_path}:Group - ${group}"],
    ],
  }
}
