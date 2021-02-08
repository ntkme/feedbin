FROM docker.io/ntkme/systemd-podman:latest

RUN podman pull docker.io/library/caddy:2-alpine \
 && podman pull docker.io/library/elasticsearch:2.4-alpine \
 && podman pull docker.io/library/memcached:1-alpine \
 && podman pull docker.io/library/postgres:13-alpine \
 && podman pull docker.io/library/redis:5-alpine \
 && podman pull docker.io/minio/mc \
 && podman pull docker.io/minio/minio \
 && podman pull docker.io/ntkme/feedbin \
 && rm -rf /usr/share/containers/storage \
 && mv /var/lib/containers/storage /usr/share/containers/storage

ADD etc /etc
ADD usr /usr

VOLUME ["/data"]
