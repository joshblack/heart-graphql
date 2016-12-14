FROM elixir:1.3.4

RUN mkdir -p /usr/src/heart-graphql
WORKDIR /usr/src/heart-graphql

ADD . .

ENV HOST 0.0.0.0
ENV PORT 4000

RUN mix local.hex --force
RUN mix deps.get
RUN mix compile

CMD ["mix", "phoenix.server"]
