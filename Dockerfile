FROM ruby:2.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y vim \
    && apt-get install -y nodejs yarn \
    && mkdir /fes_app
WORKDIR /fes_app
COPY Gemfile //Gemfile
COPY Gemfile.lock /fes_app/Gemfile.lock
RUN bundle install
COPY . /fes_app

COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3009
# CMD ["rails", "server", "-b", "0.0.0.0"]

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
