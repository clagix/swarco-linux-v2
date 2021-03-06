#!/bin/sh
#
# Start the network....
#

start() {
 	echo "Starting USB network interface..."
	insmod /lib/modules/`uname -r`/kernel/drivers/usb/gadget/g_ether.ko \
                host_addr=00:dc:c8:f7:75:05 dev_addr=00:dd:dc:eb:6d:f1
        ifconfig usb0 169.254.17.101 netmask 255.255.255.0
        # start dhcp server for usb-Gadget RNDIS interface!
        udhcpd /etc/udhcp-usb0.conf
}	
stop() {
	echo -n "Stopping USB network interface..."
        ifconfig usb0 down
}
restart() {
	stop
	start
}	

case "$1" in
  start)
  	start
	;;
  stop)
  	stop
	;;
  restart|reload)
  	restart
	;;
  *)
	echo $"Usage: $0 {start|stop|restart}"
	exit 1
esac

exit $?

# Local Variables:
# mode: shell-script
# backup-inhibited: t
# End:
