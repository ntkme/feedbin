FROM docker.io/library/ruby:3.3.6

COPY vendor/github.com /opt

RUN apt-get update \
 && apt-get install -y --no-install-recommends libidn11-dev libvips42 nodejs npm postgresql-client \
 && rm -rf /var/lib/apt/lists/* \
 && gem update --system \
 && npm install -g yarn \
 && cd /opt/feedbin/feedbin \
 && bundle install \
 && cd /opt/feedbin/privacy-please \
 && bundle install \
 && cd /opt/feedbin/extract \
 && npm ci \
 && mkdir users \
 && PIGO_TAG_NAME=$(basename "$(curl -fsSLo /dev/null  --write-out "%{url_effective}\n" https://github.com/esimov/pigo/releases/latest)") \
 && PIGO_DIR=pigo-$(echo "$PIGO_TAG_NAME" | tr -d v)-linux-amd64 \
 && curl -fsSL https://github.com/esimov/pigo/releases/download/$PIGO_TAG_NAME/$PIGO_DIR.tar.gz | tar -vxzC /opt \
 && ln -s /opt/$PIGO_DIR/pigo /usr/local/bin/pigo

WORKDIR /opt/feedbin/feedbin

CMD ["bundle", "exec", "foreman", "start"]
