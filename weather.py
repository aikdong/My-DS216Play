#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import pyowm
import datetime
import socket
import socks
import os
from gtts import gTTS

# See:
# https://github.com/csparpa/pyowm
# https://github.com/Anorov/PySocks
# https://github.com/pndurette/gTTS


owm = pyowm.OWM(API_key='1f4e3c6bc64e4d81a5d6bc2d9eb90e00',language='zh', subscription_type='free')
# 1814906  YuBei ChongQing China
locationID = 1814906
if (pyowm.timeutils.tomorrow(0,0) - datetime.datetime.now()).seconds/3600 < 8 :
    forecast = owm.daily_forecast_at_id(locationID, 2).get_forecast()
    weather = forecast.get(1)
    dayName = '明天'
else:
    forecast = owm.daily_forecast_at_id(locationID, 1).get_forecast()
    weather = forecast.get(0)
    dayName = '今天'

temperature = weather.get_temperature(unit='celsius')

weatherText = "天气预报：{0}白天最低{1:.0f}度，最高{2:.1f}度，晚间{3:.0f}度，{4}，湿度{5:.0f}%".format(
    dayName,
    temperature['min'],
    temperature['max'],
    temperature['night'],
    weather.get_detailed_status(),
    weather.get_humidity())

socks.set_default_proxy(socks.SOCKS5, "127.0.0.1", 1088)
socket.socket = socks.socksocket
tts = gTTS(text=weatherText, lang='zh-cn')
tts.save("/tmp/weather.mp3")

os.system('airplay.sh WEATHER')
