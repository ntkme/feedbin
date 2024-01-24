FROM ghcr.io/ntkme/systemd-podman:edge

RUN podman pull docker.io/library/caddy:2-alpine \
 && podman pull docker.io/library/elasticsearch:8.10.2 \
 && podman pull docker.io/library/postgres:16-alpine \
 && podman pull docker.io/library/redis:6-alpine \
 && podman pull docker.io/minio/mc:latest \
 && podman pull docker.io/minio/minio:latest \
 && podman pull docker-daemon:localhost/feedbin:edge \
 && rm -rf /usr/share/containers/storage \
 && mv /var/lib/containers/storage /usr/share/containers/storage

ADD etc /etc
ADD usr /usr

VOLUME ["/data"]
