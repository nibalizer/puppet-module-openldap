#test pp file for puppet-module-openldap

node default {

  class { 'openldap::server':
  }

}
