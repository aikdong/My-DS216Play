#!/bin/sh

# Install python3 from Package Center


# Install shadowsocks
# /volume1/\@appstore/py3k/usr/local/bin/python3 -m ensurepip
# /volume1/\@appstore/py3k/usr/local/bin/pip3 install --upgrade pip
# /volume1/\@appstore/py3k/usr/local/bin/pip3 install shadowsocks
# /volume1/\@appstore/py3k/usr/local/bin/pip3 install pyowm
# /volume1/\@appstore/py3k/usr/local/bin/pip3 install gTTS
# /volume1/\@appstore/py3k/usr/local/bin/pip3 install PySocks


cd /volume1/homes/aik/DSM/
cp ./shadowsocks.json /etc/

# Auto run script
cp ./S99*.sh /usr/local/etc/rc.d/
chmod 755 /usr/local/etc/rc.d/S99*.sh
/usr/local/etc/rc.d/shadowsocks.sh restart
/usr/local/etc/rc.d/CNTV.sh restart

# Copy files to Web station folder
cp ./ss.pac /volume1/web/
cp ./hexo.sh /volume1/web/

# Airpaly
cp ./airplay.sh /usr/local/bin/
chmod 755 /usr/local/bin/airplay.sh

# Weather
cp ./weather.py /usr/local/bin/

# PM2.5
cp ./pm25.py /usr/local/bin/

