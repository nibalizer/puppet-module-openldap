class openldap::params {

  if $operatingsystem == 'ubuntu' {
    $openldap_package_name = 'slapd'
    $openldap_service_name = 'slapd'
  }

}
