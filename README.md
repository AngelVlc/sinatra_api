# SINATRA API WITH JWT AUTH

## Env vars
- JWT_SECRET
- JWT_ISSUER
- API_PORT

## Installation
```
bundle install
```

## Start witoout docker
```
JWT_SECRET=wadus JWT_ISSUER=wadus rackup
```

## Docker
```
JWT_SECRET=secret JWT_ISSUER=is API_PORT=2900 docker-compose up
```

## Links

https://auth0.com/blog/ruby-authentication-secure-rack-apps-with-jwt/

