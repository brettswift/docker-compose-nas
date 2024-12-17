# home.brettswift.com Setup Notes

.env file lives in `s3://home.brettswift.com.assets-845689384714/`

## PopOS Host Setup

```shell
sudo chmod 666 /var/run/docker.sock


```

Docker socket configuration, follow [this](https://gist.github.com/styblope/dc55e0ad2a9848f2cc3307d4819d819f)

snippet to run:

```bash
todo
```

## DNS

DO use the stage letsencrypt for testing. Once you get it, move to the real one.

## Prowlarr

1. Add Indexers here
2. Add Radarr and Sonarr as apps.  Prowlarr's purpose is to manage their indexers in one place.
3. Configure indexer sync settings:
   1. Go to `Settings` > `Indexer Sync`.
   2. Set the sync interval as needed.
   3. Enable automatic sync for Radarr and Sonarr.

> Note, you will have to set up the download client in each radarr and sonarr:
>
> 1. Add QbitTorrent manually as the download client
>     * hostname: `qbittorrent`.  
>     * use 8080 as the port
>     * and leave the `/qbittorrent` path out.

## Folder structure setup

Manual setup is required for each of these. See sections below

```sh
data
├── torrents
│  ├── movies
│  └── series
├── usenet (optional, only if using)
│  ├── movies
│  └── tv
└── media
    ├── movies
    ├── series
    └── formula1
```

To create the above file system in `/mnt/plexbinaries/data` run:

```bash
mkdir -p /mnt/data/{torrents/{movies,series},usenet/{movies,series},media/{movies,series,formula1}}
chmod -R 777 /mnt/data
```

### Radarr & Sonarr

1. Settings >  add root folder
   1. `/data/media/movies`
   2. `/data/media/series`

## QbitTorrent

You'll have to manually set `/vuetorrent` in the custom UI settings.

The env var password doesn't work so get it out of the logs. `docker compose logs qbittorrent` on the first time it spins up.

1. Enable RSS Feeds
   1. Go to `RSS` tab in the qBittorrent web UI.
   2. Click on `New subscription` and add the RSS feed URL.
   3. Configure the RSS feed settings as needed.

2. Set Download Directory
   1. Go to `Tools` > `Options` > `Downloads`.
   2. Set the default save path to `/downloads/torrents`.
   3. **Note**: Don't set a separate completed downloads path - Radarr/Sonarr will handle moving files to the media folders.

3. Verify the settings in `docker-compose.yml`
   1. Ensure the volumes are correctly mapped:

      ```yaml
      volumes:
        - ${CONFIG_ROOT:-.}/qbittorrent:/config
        - ${DOWNLOAD_ROOT}:/downloads/torrents
      ```

   2. Ensure the environment variables are set correctly for paths if needed.

4. Configure Categories (Optional but recommended)
   1. Go to `Tools` > `Options` > `Downloads`.
   2. Add categories for:
      - movies
      - series
   3. These will be used by Radarr and Sonarr automatically.

## Jellyseer
   1. use the url `jellyfin`
   2. url base: `/jellyfin`
   3. no TLS
   4. log in with jellyfin user



### Plex
