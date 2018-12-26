# SINATRA API WITH JWT AUTH [![Build Status](https://travis-ci.org/AngelVlc/sinatra_api.svg?branch=master)](https://travis-ci.org/AngelVlc/sinatra_api)

## Installation
```
bundle install
```

## Start
```
foreman start
```

## Tests
```
bundle exec rspec
```

## Console
```
bundle exec ruby script/console
```

## Bundle audit
```
bundle-audit update
bundle-audit check
```

## Travis
To encrypt config files:
```
travis encrypt-file ./config/app.yml
travis encrypt-file ./config/database.yml
```

To encrypt the heroku api key:
```
travis encrypt heroku_api_key -r AngelVlc/sinatra_api
```

## Docker
```
docker run --name sinatra-mysql -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 -d mysql
docker run --name sinatra-postgres -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres
```

## Links

https://auth0.com/blog/ruby-authentication-secure-rack-apps-with-jwt/
