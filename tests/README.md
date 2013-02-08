Testing Puppet Modules
======================

This is janky as shit. But it tests the module.

Basically grab some lxcs or vms or whatever, setup root logins, install puppet, write down their ips.

Open up testcenter.sh, look at the key value tests array

You need to put your ips in the tests array

If you want to use the same vm w/ snapshoting or reprovisioning or something thats fine, just modify the loop in testcommand.sh to do those steps for you

I hacked this together with lxcs a la https://bke.ro/running-512-containers-on-a-laptop/


Adding more tests
=================

Create a .pp file with the puppet node information you want

Add lines of shell prepended with '#!'

