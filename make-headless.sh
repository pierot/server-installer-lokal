#!/usr/bin/env bash

wget -N --quiet https://raw.github.com/pierot/server-installer/master/lib.sh; . ./lib.sh

_redirect_stdout 'base'
_check_root

###############################################################################

ip="192.168.56.5"

###############################################################################

_usage() {
  _print "

Usage:              make-headless.sh -h [-i '192.168.56.5']

Remote Usage:       bash <( curl -s https://raw.github.com/pierot/server-installer-lokal/master/make-headless.sh ) [-i '192.168.56.5']

Options:
 
  -h                Show this message
  -i 'ip'           Set server ip address
  "

  exit 0
} 

###############################################################################

while getopts :hs:n:d:e: opt; do 
  case $opt in
    h)
      _usage
      ;;
    i)
      ip=$OPTARG
      ;;
    *)
      _error "Invalid option received"

      _usage

      exit 0
      ;;
  esac 
done

###############################################################################

_add_network_interfaces() {
	_log "Add network interfaces"

  # auto eth0 
  # iface eth0 inet dhcp

	network_interfaces="
auto eth1\n
iface eth1 inet static\n
  address 192.168.56.5\n
  netmask 255.255.255.0\n
  network 192.168.56.0\n
  broadcast 192.168.56.255\n
"

  # sudo vim /etc/network/interfaces
  echo -e $network_interfaces | sudo tee -a /etc/network/interfaces >> /dev/null

  sudo /etc/init.d/networking restart
}

###############################################################################

_add_network_interfaces
_note_installation "make-headless"
