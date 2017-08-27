FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp


# FROM ubuntu:16.04

# RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
# RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# RUN apt-get update && apt-get install -y software-properties-common python-software-properties
# RUN add-apt-repository main
# RUN add-apt-repository universe
# RUN add-apt-repository restricted
# RUN add-apt-repository multiverse

# RUN apt-get update && apt-get install -y \
#             nginx openssh-server git-core openssh-client curl \
#             nano build-essential openssl \
#             libreadline6 libreadline6-dev curl zlib1g zlib1g-dev  \
#             libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev \
#             libxslt-dev autoconf libc6-dev ncurses-dev automake libtool \
#             bison subversion pkg-config \
#             gnupg gnupg2 \
#             libpq-dev

# # install RVM, Ruby, and Bundler
# RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
# RUN \curl -sSL https://get.rvm.io | bash -s stable

# RUN /bin/bash -l -c "rvm requirements"
# RUN /bin/bash -l -c "rvm install 2.4.1"
# RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# WORKDIR /app
# ADD Gemfile* /app/
# RUN /bin/bash -l -c "bundle install" 
# ADD . /app/ 
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]