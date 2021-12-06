FROM ruby:2.3.7

ENV RAILS_ENV=production
ENV RACK_ENV=production

RUN mkdir /profileapp
WORKDIR /profileapp

COPY Gemfile /profileapp/Gemfile
RUN bundle install
COPY . /profileapp

EXPOSE 3000

# Start the main process.
RUN chmod +x docker/startup.sh
CMD ["docker/startup.sh"]