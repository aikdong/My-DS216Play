#!/bin/sh


usage() {
        cat <<EOF
Usage: $(basename $0) [start|stop|restart]
EOF
}

start_services() {
	#Shadowsocks
	/volume1/\@appstore/py3k/usr/local/bin/sslocal -c /etc/shadowsocks.json -d start --pid-file /tmp/sslocal.pid --log-file /var/log/sslocal.log
}

stop_services() {
	# kill the processes
	pids=`cat /tmp/sslocal.pid`
	if [ "${#pids[@]}" -gt 0 ]; then
		sudo kill -9 "${pids[@]}";
	fi
	echo "sudo kill sslocal ${pids[@]}"
}

action=$1
shift;

case $action in
	start)
		start_services
		;;
	stop)
		stop_services
		;;
	restart)
		stop_services && start_services
		;;
	*)
		usage
		;;
esac
