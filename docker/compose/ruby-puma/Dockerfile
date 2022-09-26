FROM debian:bullseye

ENV RUBY_VERSION="2.5.3"
ENV NODEJS_VERSION="16"

USER root
RUN apt-get update && \
    apt-get install curl gnupg2 bash procps git libpq-dev libxml2-dev shared-mime-info libcurl4-openssl-dev \
    -y
RUN curl -fsSL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash -
RUN apt-get install nodejs -y
RUN adduser --disabled-password -u 1000 amplify
RUN gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io | bash -s
RUN bash -l -c ". /etc/profile.d/rvm.sh && rvm install ${RUBY_VERSION}"
RUN bash -l -c "gem install bundler"
RUN bash -l -c "gem update --system 3.2.3"

# RUN apk add php7.4-memcached imagemagick
WORKDIR /data
RUN bash -l -c "pwd && ls -al"
COPY ./Gemfile /data/Gemfile
COPY ./Gemfile.lock /data/Gemfile.lock
RUN bash -l -c ". /etc/profile.d/rvm.sh && rvm use ${RUBY_VERSION}"
RUN bash -l -c "bundle install"
RUN chown -R amplify /data
RUN chmod -R ug+rw /data

USER amplify
WORKDIR /data
RUN bash -l -c ". /etc/profile.d/rvm.sh && rvm use ${RUBY_VERSION}"
COPY . .
COPY docker/compose/ruby-puma/application.yml config/application.yml
COPY docker/compose/ruby-puma/database.yml config/database.yml
COPY docker/compose/ruby-puma/secrets.yml config/secrets.yml

USER root
RUN chown -R amplify /data
RUN chmod -R ug+rw /data

USER amplify
RUN bash -l -c ". /etc/profile.d/rvm.sh && ls -al /data/tmp && bundle exec rake assets:precompile"
# "rvm", "2.5.3", "do", 
CMD ["source", "/etc/profile.d/rvm.sh", "&&", "rvm", "do", "bundle", "exec", "puma", "-C", "config/puma.rb"]
# --daemon amplify
