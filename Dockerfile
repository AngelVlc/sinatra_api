FROM ruby:2.2

RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
ENV RACK_ENV production

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

CMD ["rackup", "-o", "0.0.0.0", "-p", "3000"]