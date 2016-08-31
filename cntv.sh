#!/bin/sh


usage() {
        cat <<EOF
Usage: $(basename $0) [start|stop|restart]
EOF
}

start_services() {
	#cntv proxy
	cd /volume1/web/cntv/
	nohup node /volume1/web/cntv/cntv.js > /volume1/web/cntv/cntv.log &
}

stop_services() {
	# kill the processes
	pids=`cat /tmp/cntv.pid`
	if [ "${#pids[@]}" -gt 0 ]; then
		kill -9 "${pids[@]}";
	fi
	echo "sudo kill cntv ${pids[@]}"
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
