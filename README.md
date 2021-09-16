# container-feedbin

Whole Feedbin stack in a container.

## Usage

#### Add DNS Records

- `feedbin.domain.name`
- `api.feedbin.domain.name`
- `camo.feedbin.domain.name`
- `minio.feedbin.domain.name`

#### Start Feedbin in a Container

###### With `podman`

``` sh
sudo podman run -d \
  --name feedbin \
  --privileged \
  --hostname feedbin.domain.name \
  --publish 80:80/tcp \
  --publish 443:443/tcp \
  --volume /var/lib/feedbin:/data \
  ghcr.io/ntkme/feedbin
```

###### With `docker`

``` sh
docker run -d \
  --name feedbin \
  --privileged \
  --hostname feedbin.domain.name \
  --publish 80:80/tcp \
  --publish 443:443/tcp \
  --volume /var/lib/feedbin:/data \
  --device /dev/fuse \
  --stop-signal SIGRTMIN+3 \
  ghcr.io/ntkme/feedbin
```

#### Grant Admin Access

###### With `podman`

``` sh
sudo podman exec feedbin podman exec feedbin rake feedbin:make_admin[support@feedbin.domain.name]
```

###### With `docker`

``` sh
docker exec feedbin podman exec feedbin rake feedbin:make_admin[support@feedbin.domain.name]
```
