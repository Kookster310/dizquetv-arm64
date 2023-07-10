#!/bin/bash

# Download and install DizqueTV
cd /opt && git clone https://github.com/vexorian/dizquetv.git
cd /opt/dizquetv && git checkout 1.5.0 && \
	npm install && \
	npm run build


# Update tvtv2xmltv php script with env vars
sed -i "s/##TVTIMEZONE##/$TVTIMEZONE/g" /etc/nginx/tvtv2xmltv.php
sed -i "s/##LINEUPID##/$LINEUPID/g" /etc/nginx/tvtv2xmltv.php

# Build initial local guide
/usr/bin/php /etc/nginx/tvtv2xmltv.php | tee -a /etc/nginx/local-xmltv.xml

# Start services
service cron start
service nginx start
cd /opt/dizquetv && npm start
