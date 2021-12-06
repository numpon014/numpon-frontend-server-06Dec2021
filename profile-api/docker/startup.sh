#! /bin/sh

#./docker/wait-for-services.sh

# If database exists, migrate. Otherweise setup (create and seed)
bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup

bundle exec puma -C config/puma.rb