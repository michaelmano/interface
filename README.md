# Interface

## Getting Started:
  * Set up the environment and variables by copying over the `.env.example` to `.env`
  * Install dependencies with `mix deps.get`
  * Create, migrate and seed your database with `mix ecto.setup`
  * Start Interface with `./run.sh`

Now you can visit [`localhost:4000`](http://localhost:4000/graphiql) from your browser.

# API - Login/Logout/Register and Refreshing tokens.

## Login to generate an access and refresh token (username:password must be Base64 encoded)
```
**Below is using the default seeded user echos it out into the Authorization header**
user=$(echo -n 'user@example.com:password' | base64)
curl -X POST \
  -H 'Authorization: Basic '$user \
  -H 'Device-Info: Galaxy S6' \
  -H 'Content-Type: application/json' \
    http://localhost:4000/auth/login
```

## Logout of the current device/website (delete the refresh token and access tokens associated with it.)
**TODO: Remvoe access tokens generated with this refresh token.**
```
curl -X POST \
  -H 'Authorization: Bearer <TOKEN>' \
  -H 'Device-Info: Galaxy S6' \
  -H 'Content-Type: application/json' \
    http://localhost:4000/auth/logout
```

## Exchange a refresh token for an access token
```
curl -X POST \
  -H 'Authorization: Bearer <TOKEN>' \
  -H 'Device-Info: Galaxy S6' \
  -H 'Content-Type: application/json' \
    http://localhost:4000/auth/refresh
```

## Example to request all users
```
curl -X POST \
  -H 'Authorization: Bearer <TOKEN>' \
  -H 'Content-Type: application/json' \
  -d '{ "query": "{ users { name } }" }' \
    http://localhost:4000/api
```

# GraphQL

## GET Reqests via Browser for non authenticated routes.
```
http://localhost:4000/api?query={users{name}}
```
