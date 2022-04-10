FROM ruby:2.7.5

RUN apt-get update -qq && apt-get install -y build-essential nodejs  postgresql-client

WORKDIR /favoreyo

COPY Gemfile  Gemfile.lock /favoreyo/
RUN gem update --no-document --system 3.3.4 && \
    gem install --no-document bundler:2.3.4 && \
    bundle install
RUN bundle exec rails assets:precompile

COPY . /favoreyo

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

#RUN if [ "$RAILS_ENV" = "production" ]; then SECRET_KEY_BASE=$(bundle exec rails secret) bundle exec rails assets:precompile; fi

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
