#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import requests,json
import datetime
import socket,socks
import os
from gtts import gTTS

# See:

# https://github.com/Anorov/PySocks
# https://github.com/pndurette/gTTS

old_aqi = 0
filename = '/tmp/pm25.data'
old_time = None
if os.path.isfile(filename):
    with open(filename) as f:
        data = json.load(f)
        old_aqi = data[0][u'aqi']
        old_time = data[0][u'time_point']

#-------Get PM2.5-----------#
url = 'http://www.pm25.in/api/querys/aqis_by_station.json?station_code=1423A&token=5j1znBVAsnSf5xQyNQyq'
response = requests.get(url)
data = response.json()
new_aqi = data[0][u'aqi']
new_time = data[0][u'time_point']

if old_time != new_time:
    # Save file
    with open(filename, 'wb') as f:
        f.write(response.text.encode('utf-8'))

    weatherText = None
    if new_aqi >= 200 and old_aqi < 200:
        weatherText = '请注意，空气质量严重恶化：'+new_aqi+'，尽量不要外出，尽量不要外出'
    if new_aqi >= 100 and old_aqi < 100:
        weatherText = '空气质量差：'+new_aqi+'，请关窗'
    elif old_aqi >= 100 and new_aqi < 60:
        weatherText = '现在，空气质量已好转'

    pre = '空气质量报告：'
    if weatherText != None:
        socks.set_default_proxy(socks.SOCKS5, "127.0.0.1", 1088)
        socket.socket = socks.socksocket
        tts = gTTS(text=pre+weatherText, lang='zh-cn')
        tts.save("/tmp/pm25.mp3")

        # os.system('airplay.sh PM25')
