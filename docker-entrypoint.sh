#!/bin/bash

# Update tvtv2xmltv php script with env vars
sed -i "s/##TVTIMEZONE##/$TVTIMEZONE/g" /etc/nginx/tvtv2xmltv.php
sed -i "s/##LINEUPID##/$LINEUPID/g" /etc/nginx/tvtv2xmltv.php

# Build initial local guide
/usr/bin/php /etc/nginx/tvtv2xmltv.php | tee -a /etc/nginx/local-xmltv.xml

# Start services
service cron start
service nginx start
cd /opt/dizquetv && npm start
