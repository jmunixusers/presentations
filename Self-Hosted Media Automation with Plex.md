---
marp: true
---

## What is a media server?

As the name suggests, a media server is a server that can serve locally-stored media (such as movies and TV shows) over a network. This is typically accomplished through the use of Plex, although other options, such as Jellyfin, also exist.

## Why self-host this?

**Centralization**: All media that you own physical copies of (or potentially don't own, as we'll discuss shortly) can be ripped and stored in one place.

**Convenience**: Plex and Jellyfin both allow you to watch anything on your media server on pretty much any device in your network. If you port forward, you can even access your media outside of your network.

**Cost**: The cost is fairly minimal to get started. All you really need is a decent internet connection, any computer made in the last ten years or so (remember, a server is defined by its role, not its hardware), and potentially a VPN (if you decide to torrent). Compared to subscribing to multiple streaming services, this is a pretty easy sell.

## Plex vs. Jellyfin, which one should I use?

It’s really up to you; here are some factors that can influence your decision:

Plex is closed-source, and has critical features such as hardware transcoding and mobile playback behind a paywall, but it has a downloadable client on basically any platform with very few issues. The base functionality of Plex exists even if you don’t opt for a subscription or one-time lifetime membership fee.

Jellyfin is free and open-source software, and is forked from another media server application called Emby. Critical features, such as hardware transcoding, are free of charge and (hopefully) always will be. The downside is that the Jellyfin client has spotty support on multiple devices, and can require a bit more effort to get working just right.

Personally, I use both! (Plex for my parents, Jellyfin for myself).

## The elephant in the room: how do we acquire media?

(DISCLAIMER: Only download media which you have the right to download, such as content in the public domain. I do not condone piracy).

There are three main ingredients to this stack, which can be summarized as follows:

**Indexers:** Basically websites that have a repository of media that you can choose from, these are typically handled through software such as Jackett or Prowlarr that aggregates them and passes them to your PVR.

**Personal Video Recorder (PVR) software:** These are responsible for requesting and sorting your media. There are two main ones, Sonarr for TV shows, Radarr for movies. (There’s a few others for things like music and books as well).

**Torrenting software:** qBittorrent, Transmission and Deluge are the main players here. No matter what you choose, **always make sure you use a VPN**.

## File organization

Organizing your media files is tricky, because multiple applications need to know where they are. I like to organize my files into two separate directories. The`media` directory which is where our completed media files live, and `torrents` where our current downloads live, and add subdirectories for `tv` and `movies` in each of them.

This sounds complicated, but in reality Sonarr and Radarr do a lot of the work for you under the hood by moving complete torrent downloads into the `media` folder, which is why they're so great.

Here's a sample file directory structure to get you started:

```
data
├── torrents
│   ├── movies
│   └── tv
└── media
     ├── movies
     └── tv
```

## How do we run this?

There are plenty of options to run a media stack, but my personal favorite is containerization using Docker, specifically Docker Compose, which is a way to define and launch Docker containers in a YAML config file.

The best part about Docker Compose is that you can define your entire stack in a single file! Once we have this file, we can spin it up (`docker-compose up -d`) or turn it off (`docker-compose down`) on demand.

Here's a sample `docker-compose.yml` file that uses Plex for our media server, Radarr and Sonarr for our PVR software, Prowlarr as our indexer software, and qBittorrent for our torrenting software.


```yaml
version: "3"
services:

# Plex
  plex:
    container_name: plex
    image: ghcr.io/hotio/plex
    ports:
      - "32400:32400"
    environment:
      - PUID=<plex_user_id>
      - PGID=<plex_group_id>
      - UMASK=002
      - TZ=Etc/UTC
      - PLEX_CLAIM_TOKEN
      - PLEX_ADVERTISE_URL
      - PLEX_NO_AUTH_NETWORKS
      - PLEX_BETA_INSTALL=false
      - PLEX_PURGE_CODECS=false
    volumes:
      - /<host_folder_config>:/config
      - /<host_folder_transcode>:/transcode
      - /<host_folder_data>:/data:ro

# Radarr
  radarr:
    container_name: radarr
    image: ghcr.io/hotio/radarr
    ports:
      - "7878:7878"
    environment:
      - PUID=<radarr_user_id>
      - PGID=<radarr_group_id>
      - UMASK=002
      - TZ=Etc/UTC
    volumes:
      - /<host_folder_config>:/config
      - /<host_folder_data>:/data

# Sonarr
  sonarr:
    container_name: sonarr
    image: ghcr.io/hotio/sonarr
    ports:
      - "8989:8989"
    environment:
      - PUID=<sonarr_user_id>
      - PGID=<sonarr_group_id>
      - UMASK=002
      - TZ=Etc/UTC
    volumes:
      - /<host_folder_config>:/config
      - /<host_folder_data>:/data

# Prowlarr
  prowlarr:
    container_name: prowlarr
    image: ghcr.io/hotio/prowlarr
    ports:
      - "9696:9696"
    environment:
      - PUID=<prowlarr_user_id>
      - PGID=<prowlarr_group_id>
      - UMASK=002
      - TZ=Etc/UTC
    volumes:
      - /<host_folder_config>:/config

# qBittorrent
  qbittorrent:
    container_name: qbittorrent
    image: ghcr.io/hotio/qbittorrent
    ports:
      - "8080:8080"
    environment:
      - PUID=<qbittorrent_user_id>
      - PGID=<qbittorrent_group_id>
      - UMASK=002
      - TZ=Etc/UTC
      - WEBUI_PORTS=8080/tcp,8080/udp
    volumes:
      - /<host_folder_config>:/config
      - /<host_folder_data>:/data
```

Note that this `docker-compose` is not at all optimized for every use case. A bunch of it is really up to what you want to do with your home media setup.

## Optimizations

Now that you have the base system set up, this is where the fun part begins.

This initial setup is far from perfect. This is where you as the user can decide how you can optimize it for your use case.

For instance, the default quality profiles that Radarr and Sonarr use to grab releases is not great, and frequently grabs many false positives. You can refine those settings to get your preferred streaming resolution and quality. qBittorrent is also not being run behind a VPN in this setup, but thankfully, Hotio, the maintainer of these Docker images, has also added VPN functionality into his containers.

As far as actually *requesting* media, Overseerr is a great pick. Overseer is an application that provides a pleasant user interface for you to interact with and request media, which automatically goes into Sonarr and Radarr depending on if its a show or movie.

## Exercises for the Reader

[The Servarr Wiki](https://wiki.servarr.com/) contains the concepts discussed in this presentation in far greater detail. If you're really interested in getting an automated media server set up, this is the first place you should look.

[TrasH Guides](https://trash-guides.info/) is a fantastic guide that can help you refine and optimize Sonarr, Radarr, and qBittorrent to make your media stack more efficient.

[This video by TechHut](https://www.youtube.com/watch?v=MUhpu42sWWM) provides a more detailed explanation of Jellyfin and Plex so you can decide which media server you want to use.





