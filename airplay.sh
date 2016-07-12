#!/bin/ash

AIRHOST="10.0.1.202" 
AIRPORT="5000"

PIDPATH="/run/synoairplayd.$AIRHOST.$AIRPORT.pid" 

# kill the new processes
NEWPID=`cat $PIDPATH`
if [ -s $NEWPID ]; then
    kill $NEWPID
fi

case $1 in
    MORNING ) 
    DAY=`date +%d`
    PERIPH="--volume 36 /volume1/music/MORNING/$DAY.flac" 
    ;;
    DOORBELL )
    PERIPH="--volume 46 /volume1/music/Ringtone/dingding.m4a" 
    ;;
    WEATHER )
    PERIPH="--volume 46 /tmp/weather.mp3"
    ;;
    PM25 )
    PERIPH="--volume 46 /tmp/pm25.mp3"
    ;;
    CLOCK )
    HOUR=`date +%H` 
    PERIPH="--volume 25 /volume1/music/CLOCK/01.m4a"
esac

# run the song
/var/packages/AudioStation/target/sbin/synoairplayd --ip $AIRHOST --port $AIRPORT $PERIPH --foreground

# case $1 in
# MORNING ) 
# sleep 10m 
# ;;
# DOORBELL )
# sleep 15s
# ;;
# WEATHER )
# sleep 15s
# ;;
# PM25 )
# sleep 15s
# ;;
# CLOCK )
# sleep 8s
# esac

# kill the new processes
NEWPID=`cat $PIDPATH`
if [ -s $NEWPID ]; then
    kill $NEWPID
fi
