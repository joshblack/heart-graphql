FROM elixir:1.3.4

RUN mkdir -p /usr/src/heart-graphql
WORKDIR /usr/src/heart-graphql

COPY ../../config ./config
COPY ../../lib ./lib
COPY ../../priv ./priv
COPY ../../web ./web
COPY ../../mix.exs mix.lock ./

ENV MIX_ENV prod
ENV HOST 0.0.0.0
ENV PORT 4000

RUN mix local.hex --force
RUN mix deps.get --only-prod
RUN mix compile

CMD ["mix", "phoenix.server"]
