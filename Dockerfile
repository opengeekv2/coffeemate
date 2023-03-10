FROM ruby:3.2.1
ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ARG DATABASE_URL
ARG SECRET_KEY_BASE
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /coffeemate
COPY . .
RUN bundle install

EXPOSE 3000

# Configure the main process to run when running the image
CMD rails db:migrate && rails server -b 0.0.0.0