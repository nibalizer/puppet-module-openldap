#!/bin/bash

ip_addr=$1
testfile=$2
ssh_options="\
  -o VerifyHostKeyDNS=no \
  -o StrictHostKeyChecking=no"

pushd ../..

ssh $ssh_options root@$ip_addr 'rm -fr puppet'
ssh $ssh_options root@$ip_addr 'mkdir -p puppet/{modules,manifests}'

scp $ssh_options -r puppet-module-openldap root@$ip_addr:puppet/modules/openldap
scp $ssh_options puppet-module-openldap/tests/$testfile root@$ip_addr:puppet/manifests/$testfile


ssh root@$ip_addr "puppet apply \
  --modulepath=puppet/modules \
  $PUPPET_ARGS \
  puppet/manifests/$testfile"

echo "Running puppet tests"

./puppet-module-openldap/tests/testfire.rb puppet-module-openldap/tests/$testfile $ip_addr

if [ $? = 0 ]; then
  popd
  echo "All tests pass. w00t"
else
  popd
  echo "Tests failed :("
  exit 1
fi




