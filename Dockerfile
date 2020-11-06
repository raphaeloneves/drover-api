FROM ruby:2.6.5

RUN apt-get update -qq \
  && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    # reduce image size
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log

RUN mkdir /drover-api
WORKDIR /drover-api

RUN gem install bundler -v 2.1.4
COPY Gemfile* /drover-api/
RUN bundle install
ADD . /drover-api/

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]






