FROM docker.io/library/ruby:3.0.2

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
 && apt-get install -y --no-install-recommends libidn11-dev libvips42 nodejs postgresql-client \
 && rm -rf /var/lib/apt/lists/* \
 && gem install bundler \
 && npm install -g yarn \
 && git clone --depth 1 https://github.com/feedbin/feedbin.git /opt/feedbin/feedbin \
 && cd /opt/feedbin/feedbin \
 && bundle install \
 && git clone --depth 1 https://github.com/feedbin/image.git /opt/feedbin/image \
 && cd /opt/feedbin/image \
 && bundle install \
 && git clone --depth 1 https://github.com/feedbin/refresher.git /opt/feedbin/refresher \
 && cd /opt/feedbin/refresher \
 && bundle install \
 && git clone --depth 1 https://github.com/feedbin/extract.git /opt/feedbin/extract \
 && cd /opt/feedbin/extract \
 && npm install \
 && mkdir users \
 && git clone --depth 1 https://github.com/atmos/camo.git /opt/atmos/camo

WORKDIR /opt/feedbin/feedbin

CMD ["bundle", "exec", "foreman", "start"]
