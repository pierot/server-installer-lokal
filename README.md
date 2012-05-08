Make your local Ubuntu installation (in VirtualBox in this case) available via ssh

Reason
======
From time to time, I run an Ubuntu virtual host on my Mac OSX machine (in VirtualBox) for testing and trying. It took me a while to figure out how to setup this virtual machine so it has access to the Internet as well as local access to my host.

For referencial purposes, here goes:

VirtualBox settings
-------------------
In your VirtualBox preferences, add a 'host-only network' (vboxnet0). 
### Adapter Settings:
`IPv4 address: 192.168.56.1`
`IPv4 Network Mask: 255.255.255.0`

### DHCP Server:
`Server Address: 192.168.56.100`
`Server Mask: 255.255.255.0`
`Lower Address Bound: 192.168.56.101`
`Upper Address Bound: 192.168.56.254`

Make sure you have your VirtualBox instance set up with two networks interfaces: 
* NAT (1) 
* and Host-only (2). 
Default settings are ok.

Ubuntu settings
---------------
Execute this:
`bash <( curl -s https://raw.github.com/pierot/server-installer-lokal/master/make-headless.sh ) [-i '192.168.56.5']`

It will add the network interface for your local connection.
You can now ssh into your Linux.
