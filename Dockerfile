FROM ruby:2.7.7
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /coffeemate
COPY Gemfile /coffeemate/Gemfile
COPY Gemfile.lock /coffeemate/Gemfile.lock
RUN bundle install

EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]