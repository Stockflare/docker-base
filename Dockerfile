FROM alpine:3.4

ENV DEBIAN_FRONTEND noninteractive

ENV BUILD_PACKAGES="build-base ca-certificates libxml2 libxslt openssl yaml git zlib glib"

ENV RUBY_PACKAGES="ruby ruby-io-console ruby-dev ruby-bundler ruby-irb"

# Configure deps.
RUN apk update && apk upgrade && apk add ${BUILD_PACKAGES} ${RUBY_PACKAGES} && rm -rf /var/cache/apk/* \
    && echo 'gem: --no-document' >> ~/.gemrc && echo 'gem: --no-document' >> /etc/gemrc

# Setup the working directory
WORKDIR /stockflare

# Add current working directory in child builds
ONBUILD ADD ./ /stockflare

# Bundle install child working directory
ONBUILD RUN bundle install

# Default the command to start the server
CMD ["puma"]
