class openldap::server (
  $package_ensure  = installed,
  $manage_packages = 'true',
  $service_ensure  = enabled
){

  if $manage_packages == 'true' {

    package { 'slapd':
      ensure => $package_ensure,
      name   => $openldap::params::openldap_package_name,
    }

    class { 'openldap::server::utils':
      package_ensure  => $package_ensure,
      manage_packages => $manage_packages,
    }

  }

  service { 'slapd':
    ensure    => $service_enable,
    name      => $openldap::params::openldap_service_name,
    enable    => $service_enable,
    subscribe => Package['slapd'],
  }

}
