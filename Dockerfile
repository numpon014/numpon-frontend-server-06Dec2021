FROM ruby:3.0.3

ENV RAILS_ENV=production
ENV RACK_ENV=production

RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app/

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install

COPY . /usr/src/app/

EXPOSE 3000

# Start the main process.
RUN chmod +x docker/startup.sh
CMD ["docker/startup.sh"]