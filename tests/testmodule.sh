#!/bin/bash

ip_addr=$1
ssh_options="\
  -o VerifyHostKeyDNS=no \
  -o StrictHostKeyChecking=no"

pushd ../..

ssh $ssh_options root@$ip_addr 'rm -fr puppet'
ssh $ssh_options root@$ip_addr 'mkdir -p puppet/{modules,manifests}'

scp $ssh_options -r puppet-module-openldap root@$ip_addr:puppet/modules/openldap
scp $ssh_options puppet-module-openldap/tests/basic.pp root@$ip_addr:puppet/manifests/basic.pp

popd

ssh root@$ip_addr "puppet apply \
  --modulepath=puppet/modules \
  $PUPPET_ARGS \
  puppet/manifests/basic.pp"



