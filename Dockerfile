FROM nginx:1.11.3

MAINTAINER David Kelley <david@stockflare.com>

# Set the environment of Hodor to build
ARG stage=production

ENV DEBIAN_FRONTEND noninteractive

ENV LISTEN_ON 80

ENV CONFD_VERSION 0.10.0

ENV USER_AGENT_MATCH "googlebot|yahoo|bingbot|baiduspider|yandex|yeti|yodaobot|gigabot|ia_archiver|facebookexternalhit|twitterbot|developers\.google\.com"

RUN update-ca-certificates

# Install Node.js and other dependencies
RUN apt-get update && \
    apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get -y install python build-essential nodejs

# Install Ruby
RUN apt-get -y install git-core wget build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
RUN wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
RUN tar -xvzf ruby-2.1.2.tar.gz
RUN cd ruby-2.1.2 && ./configure --prefix=/usr/local
RUN cd ruby-2.1.2 && make
RUN cd ruby-2.1.2 && make install

# Install bower and grunt
RUN npm install bower -g
RUN npm install grunt-cli -g

# Setup the working directory
WORKDIR /stockflare
