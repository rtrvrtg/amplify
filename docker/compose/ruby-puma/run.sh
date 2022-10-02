#!/bin/bash

eval "$(rbenv init -)"
bundle exec rake assets:precompile
bundle exec puma -C config/puma.rb
