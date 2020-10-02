FROM ruby:2.7.1

# Adding NodeJS and Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install dependencies and perform clean-up
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn mariadb-server mariadb-client libmariadb-dev redis-server \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists

RUN mysql -e "use mysql; update user set authentication_string=PASSWORD('1234') where User='root'; update user set plugin='mysql_native_password';FLUSH PRIVILEGES;"
RUN mysql_upgrade --force -u root -p1234
RUN service mysql restart
RUN service redis-server restart

ENV RAILS_ENV development
ENV RACK_ENV development

RUN gem install bundler foreman