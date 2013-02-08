# Testcommand.sh

# This file fires off all tests, this should be modified for your environment
# it is a list of commands to be run in sequence, each .pp file should get its
# own clean host to go to. You could also take the time here to provision/snap-
# -shot the same host, its up to you, my version uses lxcs

fullname='puppet-module-openldap'
modulename='openldap'
timestamp=`date +%s`

tests[0]='basic.pp/10.0.3.12'
tests[1]='args.pp/10.0.3.13'



for tst in ${tests[@]}
do
  testfile=`echo $tst | cut -d '/' -f 1`
  testname=$testfile
  echo "Running test $testfile"
  #ip_addr=`echo $tst | cut -d '/' -f 2`
  echo "Creating LXC $modulename-$testname-$timestamp"
  sudo lxc-clone -s -o puppet-testing -n $modulename-$testname-$timestamp
  mac_addr=`cat /var/lib/lxc/$modulename-$testname-$timestamp/config | grep hwaddr | cut -d " " -f 2`
  echo "mac addr: $mac_addr"
  sudo lxc-start -d -n $modulename-$testname-$timestamp
  echo "LXC created, sleeping for 20 to get dhcp"
  cat /var/log/syslog | grep $mac_addr
  for i in {1..20};do echo -n "."; sleep 1; done; echo
  ip_addr=`cat /var/log/syslog | grep $mac_addr | grep DHCPACK | awk '{print $7}'`
  if [ -z "$ip_addr" ]; then 
    echo "no ip addr!"
    exit 1
  fi
  echo "testfile: $testfile"
  echo "ip_addr: $ip_addr"
  ./testmodule.sh $ip_addr $testfile
  if [ $? = 0 ]; then
    sudo lxc-destroy -n $modulename-$testname-$timestamp
    :
  else
    echo "Test $testfile failed"
    echo "You may want to ssh into $ip_addr to see what happened"
    exit 1
  fi
done

echo "All Tests pass"

