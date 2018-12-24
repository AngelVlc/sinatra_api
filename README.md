# SINATRA API WITH JWT AUTH [![Build Status](https://travis-ci.org/AngelVlc/sinatra_api.svg?branch=master)](https://travis-ci.org/AngelVlc/sinatra_api)

## Installation
```
bundle install
```

## Start
```
bundle exec rackup
```

## Tests
```
bundle exec rspec
```

## Bundle audit
```
bundle-audit update
bundle-audit check
```

## Travis
```
travis encrypt-file ./config/app.yml
``

## Docker
```
API_PORT=2900 docker-compose up
```

## Links

https://auth0.com/blog/ruby-authentication-secure-rack-apps-with-jwt/

