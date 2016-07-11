#!/bin/ash

AIRHOST="10.0.1.202" 
AIRPORT="5000"

PIDPATH="/run/synoairplayd.$AIRHOST.$AIRPORT.pid" 

# kill the old processes
if [ -s $PIDPATH ]; then
NEWPID=`cat $PIDPATH`
kill $NEWPID
fi

case $1 in
MORNING ) 
DAY=`date +%d`
PERIPH="--ip $AIRHOST --port $AIRPORT --volume 36 /volume1/music/MORNING/$DAY.flac" 
;;
DOORBELL )
PERIPH="--ip $AIRHOST --port $AIRPORT --volume 46 /volume1/music/Ringtone/dingding.m4a" 
;;
WEATHER )
PERIPH="--ip $AIRHOST --port $AIRPORT --volume 36 /tmp/weather.mp3"
;;
CLOCK ) 
HOUR=`date +%H` 
PERIPH="--ip $AIRHOST --port $AIRPORT --volume 25 /volume1/music/CLOCK/01.m4a"
esac

# run the song
/var/packages/AudioStation/target/sbin/synoairplayd $PERIPH 

case $1 in
MORNING ) 
sleep 10m 
;;
DOORBELL )
sleep 15s
;;
WEATHER )
sleep 15s
;;
CLOCK )
sleep 8s
esac

# kill the new processes
if [ -s $PIDPATH ]; then
NEWPID=`cat $PIDPATH` 
kill $NEWPID
fi
