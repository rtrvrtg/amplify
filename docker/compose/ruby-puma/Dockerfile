FROM debian:bullseye

ENV HOME /home/amplify
ENV RUBY_VERSION 2.5.3
ENV NODEJS_VERSION 16

# Install deps
USER root
RUN apt-get update && \
    apt-get install curl gnupg2 bash procps git libpq-dev libxml2-dev shared-mime-info \
    libssl-dev libcurl4-openssl-dev libreadline6-dev libyaml-dev \
    zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev \
    autoconf bison build-essential \
    -y

# Install Node
RUN curl -fsSL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash -
RUN apt-get install nodejs -y

# Add user
RUN adduser --disabled-password -u 1000 amplify

# Install rbenv and ruby-build as user
USER amplify
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'export RUBY_VERSION="$RUBY_VERSION"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
ENV PATH "$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
RUN export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
RUN mkdir -p $HOME/.rbenv/plugins
RUN git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build

# Install matching ruby version for this app
RUN $HOME/.rbenv/bin/rbenv install $RUBY_VERSION
RUN $HOME/.rbenv/bin/rbenv global $RUBY_VERSION && \
    $HOME/.rbenv/bin/rbenv versions && \
    $HOME/.rbenv/versions/$RUBY_VERSION/bin/ruby -v
# RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash # Uncomment this to get rbenv to validate your setup.
RUN $HOME/.rbenv/versions/$RUBY_VERSION/bin/gem install bundler

WORKDIR /data
RUN chown -R amplify /data
RUN chmod -R ug+rw /data

# Install deps
COPY --chown=amplify:root ./Gemfile ./Gemfile.lock /data/
RUN chmod 664 /data/Gemfile.lock
USER amplify
WORKDIR /data
RUN $HOME/.rbenv/versions/$RUBY_VERSION/bin/bundle install

# Setup app
COPY --chown=amplify:root . .
COPY --chown=amplify:root ./docker/compose/ruby-puma/*.yml /data/config/

# Enforce ownership
USER root
RUN chown -R amplify /data
RUN chmod -R ug+rw /data
RUN chmod +x docker/compose/ruby-puma/*.sh

# Precompile assets
USER amplify

# Run
CMD ["/data/docker/compose/ruby-puma/run.sh"]
