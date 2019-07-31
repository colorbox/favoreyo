FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential nodejs  postgresql-client

RUN mkdir /favoreyo

WORKDIR /favoreyo
COPY Gemfile /favoreyo/Gemfile
COPY Gemfile.lock /favoreyo/Gemfile.lock

RUN gem install bundler -v 2.0.2

RUN bundle install
RUN bundle exec rails assets:precompile

COPY . /favoreyo

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

#RUN if [ "$RAILS_ENV" = "production" ]; then SECRET_KEY_BASE=$(bundle exec rails secret) bundle exec rails assets:precompile; fi

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
