#class to bring in ldap 'extras'
class openldap::server::utils (
  $manage_packages = "true",
  $package_ensure = installed
){

  if $operatingsystem == "Ubuntu" {
      
    if $manage_packages == "true" {

      package { 'ldap-utils':
        ensure => $package_ensure,
        name   => 'ldap-utils',
      }

    }

  }

}
