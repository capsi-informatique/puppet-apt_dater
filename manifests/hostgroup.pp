# @summary Group host
#
# @param user the default user of this group
#
# @example
#   apt_dater::hostgroup { 'Internal Hosts': }
define apt_dater::hostgroup (
  Optional[String[1]] $user = undef,
) {
  include apt_dater

  xml_fragment { "${apt_dater::config_host_path}:Group - ${title}":
    ensure  => 'present',
    path    => $apt_dater::config_host_path,
    xpath   => "/hosts/group[@name='${title}']",
    purge   => true,
    content => {
      attributes => {
        'name'     => $title,
        'ssh-user' => $user,
      },
    },
    require => [
      Xml_fragment["${apt_dater::config_host_path}:Hosts"],
    ],
  }
}
