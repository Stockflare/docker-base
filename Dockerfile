FROM alpine

RUN apk update && apk upgrade \
  && apk add ca-certificates \
  && rm -rf /var/cache/apk/*

ENV RUBY_VERSION 2.2.4

ENV RUBY_BUILD 2

RUN apk update && apk upgrade

# Configure deps.
RUN apk update && apk upgrade \
    && apk add libxml2 libxslt libevent libffi glib ncurses readline \
    openssl yaml zlib curl  mariadb-libs libpq ruby ruby-io-console \
    git build-base ruby-dev bash

RUN rm -rf /var/cache/apk/*


COPY bin/broadcast /usr/bin/broadcast

RUN chmod +x /usr/bin/broadcast

# Setup the working directory
WORKDIR /stockflare

# Install Bundler
RUN echo 'gem: --no-document' >> ~/.gemrc
RUN echo 'gem: --no-document' >> /etc/gemrc
RUN gem install bundler

# Expose port 2345 and set env variable
EXPOSE 2345
ENV PORT 2345

# Add current working directory in child builds
ONBUILD ADD ./ /stockflare

# Bundle install child working directory
ONBUILD RUN bundle install

# Default the command to start the server
CMD ["puma"]
