FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install --without development test
COPY . /myapp

EXPOSE 3000

# https://gist.github.com/rwarbelow/40bd72b2aee8888d6d91
ENV RAILS_ENV=production
CMD ["bundle", "exec", "rails", "db:migrate"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
