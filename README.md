# dizquetv-arm64
## Run dizqueTV on arm64
Create live TV channel streams from media on your Plex servers.

https://github.com/vexorian/dizquetv

###  Description
This docker image is used to run dizqueTV on a board using arm64 architecture. The dizquetv service runs on port 8000.

It also runs nginx on 8001 to serve local tv listings.
I ran into a limitation with Plex while connecting it to dizquetv. When setting up Plex DVR, you're not able to do a combination of automatic guide downloading via zipcode and xml importing. It seems Plex only allows for one or the other. This can become an issue if you have multiple tuners such as an HDHomeRun.
A nice fix for this is to download your local station information from tvtv.us and convert it to an XML file.
I'm using this script by github user: [idolpx](https://google.com) which works really well: https://gist.github.com/idolpx/c82747bb740c303f56ad8a1e8f17d575
It will download one week's worth of your local listings once a day and serve it on 127.0.0.1:8001/local-xmltv.xml

For it to properly work, you'll need to include your [Timezone](https://www.php.net/manual/en/timezones.php) and the LineupID. Make sure to escape the `/` character, so your TIMEZONE should look like: `America\/New_York`. 

To obtain the LineupID, go to https://tvtv.us and enter your zipcode. Click on your city and select your TV provider. Once the guide loads, copy the appended: USA* code at the end of the URL, ex: USA-OTA30236.
### usage
``` docker run -p 8000:8000 -p 8001:8001 -e TIMEZONE=America\/New_York -e LINEUPID=USA-OTA30236 -d kookster310/dizquetv-arm64:latest ```

