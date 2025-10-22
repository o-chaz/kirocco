FROM ruby:3.1.4

RUN apt-get update -qq && apt-get install -y build-essential postgresql-client

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
