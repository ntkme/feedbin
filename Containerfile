FROM ghcr.io/ntkme/systemd-podman:edge

RUN podman pull docker.io/library/caddy:2-alpine \
 && podman pull docker.io/library/elasticsearch:8.10.4 \
 && podman pull docker.io/library/postgres:16-alpine \
 && podman pull docker.io/library/redis:6-alpine \
 && podman pull docker.io/minio/mc:latest \
 && podman pull docker.io/minio/minio:latest \
 && printf '%s\n' \
           '[[registry]]' \
           'prefix = "localhost"' \
           'location = "localhost"' \
           'insecure = true' \
  | tee /etc/containers/registries.conf.d/localhost.conf \
 && podman pull localhost:5000/feedbin:edge \
 && rm /etc/containers/registries.conf.d/localhost.conf \
 && rm -rf /usr/share/containers/storage \
 && mv /var/lib/containers/storage /usr/share/containers/storage

ADD etc /etc
ADD usr /usr

VOLUME ["/data"]
