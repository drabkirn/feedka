FROM ruby:2.7.5

MAINTAINER drabkirn@cdadityang.xyz

# Adding NodeJS and Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install dependencies and perform clean-up
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists

WORKDIR /usr/src/app

ENV RAILS_ENV development
ENV RACK_ENV development

COPY . .

RUN gem install bundler
RUN bundle install
RUN yarn install --check-files

ENTRYPOINT ["bundle", "exec"]

CMD puma -C config/puma.rb
