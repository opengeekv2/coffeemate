FROM ruby:2.7.7
ENV RAILS_ENV=production
ARG DATABASE_URL
ARG SECRET_KEY_BASE
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /coffeemate
COPY . .
RUN bundle install

EXPOSE 3000

# Configure the main process to run when running the image
CMD rails db:migrate && rails server -b 0.0.0.0