FROM ubuntu:15.04

ENV DEBIAN_FRONTEND noninteractive

ENV RUBY_VERSION 2.2

ENV RUBY_BUILD 2

# Configure deps.
RUN apt-get -y update && \
    apt-get -yq --no-install-recommends install wget build-essential mysql-client mysql-common libmysqlclient-dev \
    ca-certificates libnotify-dev \
    zlib1g-dev libssl-dev libreadline6-dev libyaml-dev libgtkmm-2.4 libsasl2-dev git-core && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Ruby
RUN wget http://ftp.ruby-lang.org/pub/ruby/$RUBY_VERSION/ruby-$RUBY_VERSION.$RUBY_BUILD.tar.gz && \
    tar -xvzf ruby-$RUBY_VERSION.$RUBY_BUILD.tar.gz && \
    cd ruby-$RUBY_VERSION.$RUBY_BUILD && ./configure --prefix=/usr/local && make && make install && \
    rm ../ruby-$RUBY_VERSION.$RUBY_BUILD.tar.gz

COPY bin/broadcast /usr/bin/broadcast

RUN chmod +x /usr/bin/broadcast

# Setup the working directory
WORKDIR /stockflare

# Install Bundler
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
