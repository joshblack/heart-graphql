# Ensure :ex_machina is started only in our Test env
{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Heart.Repo, :manual)
