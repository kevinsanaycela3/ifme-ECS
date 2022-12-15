FROM ruby:2.6.10

RUN apt-get update -qq && \
    apt-get install -y build-essential cmake git tzdata libpq-dev  ruby-dev curl

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app
WORKDIR /app
COPY . .

ENV BUNDLE_PATH=/bundle/vendor
ENV PSQL_USERNAME=postgres
ENV PSQL_PASSWORD=password
ENV PSQL_HOST=db
ENV RAILS_ENV=development
ENV NODE_ENV=development
ENV GITHUB_CLIENT_ID=
ENV GITHUB_CLIENT_SECRET=
ENV GOOGLE_CLIENT_ID=
ENV GOOGLE_CLIENT_SECRET=

RUN gem install bundler -v 2.1.4

EXPOSE 3000

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bash"]
