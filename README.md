# Interface

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000/graphiql) from your browser.

** Example to get user one and their characters **
`curl -X POST -H "Content-Type: application/json" --data '{ "query": "{ users { name } }" }' http://localhost:4000/api`

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


https://github.com/ueberauth/guardian/blob/b6ccd5d7d136bbafdf6166de7b45a2b8e0192500/lib/guardian/plug/pipeline.ex