# SINATRA API WITH JWT AUTH


## Installation
```
bundle install
```

## Start
```
JWT_SECRET=wadus JWT_ISSUER=wadus rackup
```

## Docker
```
docker build -t my_sinatra .
docker run -p 2900:3000 -e "JWT_SECRET=wadus" -e "JWT_ISSUER=wadus" my_sinatra
```

## Links

https://auth0.com/blog/ruby-authentication-secure-rack-apps-with-jwt/

