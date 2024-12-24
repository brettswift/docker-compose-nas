# SABNZBD Manual Setup Steps

## ./sabnzbd/sabnzbd.ini

* set the url_base to /sabnzbd
* get the api key for the .env file
* change the port to 8081 so qbit works. (ensure docker compose matches)

Settings should have these category configs:

`sabnzbd.ini`

```ini
[categories]
[[movies]]
dir = /downloads/movies
priority = 0
processing = 3
script = None

[[tv]]
dir = /downloads/tv
priority = 0
processing = 3
script = None

```
