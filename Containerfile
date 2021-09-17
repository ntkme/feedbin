FROM ghcr.io/ntkme/systemd-podman:edge

RUN podman pull docker.io/library/caddy:2-alpine \
 && podman pull docker.io/library/elasticsearch:2.4-alpine \
 && podman pull docker.io/library/memcached:1-alpine \
 && podman pull docker.io/library/postgres:13-alpine \
 && podman pull docker.io/library/redis:5-alpine \
 && podman pull docker.io/minio/mc:latest \
 && podman pull docker.io/minio/minio:latest \
 && podman pull docker-daemon:localhost/feedbin:edge \
 && rm -rf /usr/share/containers/storage \
 && mv /var/lib/containers/storage /usr/share/containers/storage

ADD etc /etc
ADD usr /usr

VOLUME ["/data"]
