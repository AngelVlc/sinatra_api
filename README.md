# SINATRA API WITH JWT AUTH [![Build Status](https://travis-ci.org/AngelVlc/sinatra_api.svg?branch=master)](https://travis-ci.org/AngelVlc/sinatra_api) [![Coverage Status](https://coveralls.io/repos/github/AngelVlc/sinatra_api/badge.svg?branch=master)](https://coveralls.io/github/AngelVlc/sinatra_api?branch=master)

## Characteristics

- Travis CI/CD: tests, bundle audit and deploy to heroku
- Coveralls
- Sentry error tracking
- Rack protection

## Installation
```
bundle install
```

## Start
```
make start
```

## Tests
```
make tests
```

## Console
```
make console
```

## Bundle audit
```
make bundle_audit
```

## Travis
To encrypt config files:
```
make encrypt_configs
```

## Docker for development db
```
docker run --name sinatra-mysql -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 -d mysql
```

## Sentry config for heroku
```
heroku labs:enable runtime-dyno-metadata -a <app name>
```

## Links

https://auth0.com/blog/ruby-authentication-secure-rack-apps-with-jwt/
