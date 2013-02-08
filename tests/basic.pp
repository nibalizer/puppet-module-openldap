#test pp file for puppet-module-openldap

node default {

  class { 'openldap::server':
  }

}

#!pgrep -lf slapd > /dev/null
#!ls /etc/ldap/ldap.conf > /dev/null
