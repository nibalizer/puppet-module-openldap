#test pp file for puppet-module-openldap

node default {

  class { 'openldap::server':
    package_ensure  => installed,
    manage_packages => true,
    service_ensure  => enabled,
  }

}

#!pgrep -lf slapd > /dev/null
#!ls /etc/ldap/ldap.conf > /dev/null
