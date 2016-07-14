# My-DS216Play
Some tools used in my DS216Play with DSM6.0

### airplay.sh
```
play sound stream to your airplay device with *synoairplayd*, eg:Airport Express
```

### pm25.py
```
Get china air quality‘s AQI data, and through google's gTTS transform to mp3, and play it with ***airplay.sh***
```

### S99shadowsocks.sh
```
A shell script what is automatic run shadowscocks on DSM6.0.
```

### SetupMySynology.sh
```
A script for automatic install.
```

### weather.py
```
Get weather's data from OpenWeatherMap with [pyowm](https://github.com/csparpa/pyowm)
```


## How to run all of this above
```
vi /etc/crontab

1	8	*	*	1,2,3,4,5	root	/usr/local/bin/airplay.sh MORNING
1	9	*	*	0,6 root	/usr/local/bin/airplay.sh MORNING
0	8-22	*	*	*	root	/usr/local/bin/airplay.sh CLOCK
50	7	*	*	*	root	python3 /usr/local/bin/weather.py
50	21  *	*	*	root	python3 /usr/local/bin/weather.py
2   8-21    *   *   *   root    python3 /usr/local/bin/pm25.py

/usr/syno/sbin/synoservicectl --restart crond
```