# Testcommand.sh

# This file fires off all tests, this should be modified for your environment
# it is a list of commands to be run in sequence, each .pp file should get its
# own clean host to go to. You could also take the time here to provision/snap-
# -shot the same host, its up to you, my version uses lxcs

tests[0]='basic.pp/10.0.3.12'
tests[1]='args.pp/10.0.3.13'

for tst in ${tests[@]}
do
  testfile=`echo $tst | cut -d '/' -f 1`
  ip_addr=`echo $tst | cut -d '/' -f 2`
  echo "testfile: $testfile"
  echo "ip_addr: $ip_addr"
  ./testmodule.sh $ip_addr $testfile
  if [ $? = 0 ]; then
    :
  else
    echo "Test $testfile failed"
    echo "You may want to ssh into $ip_addr to see what happened"
    exit 1
  fi
done

echo "All Tests pass"





