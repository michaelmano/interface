# Interface

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000/graphiql) from your browser.

** Example to request all users **
```
curl -X POST \
  -H 'Authorization: Bearer <TOKEN>' \
  -H 'Content-Type: application/json' \
  -d '{ "query": "{ my { name } }" }' \
    http://localhost:4000/api
```
```
curl -X POST \
  -H "Content-Type:application/json" \
  -d '{ "query": "mutation { login(email:\"email@address.com\",password:\"password\") { token } }" }' \
  'http://localhost:4000/api'

```
```
http://localhost:4000/api?query={users{name}}
```



## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix