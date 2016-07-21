#!/bin/sh


usage() {
        cat <<EOF
Usage: $(basename $0) [start|stop|restart]
EOF
}

start_services() {
	#Hexo
	cd /volume1/web/
	hexo g -d -w > hexo.log &
}

stop_services() {
	# kill the processes
	pids=`cat /tmp/hexo.pid`
	if [ "${#pids[@]}" -gt 0 ]; then
		sudo kill -9 "${pids[@]}";
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
