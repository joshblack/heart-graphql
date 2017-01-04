defmodule Heart.Relay.ConnectionHelper do
  defmacro __using__(opts) do
    verify_ecto_dep()

    if {repo, module} = get_keywords(opts) do
      quote do
        alias Absinthe.Relay.Connection

        def get_edge_for(resource) do
          case unquote(repo).all(unquote(module)) do
            # TODO: Add Heart.Error helper instead of hard coding
            nil -> {:error, "Unable to find the collection for the resource."}
            resources ->
              cursor =
                resources
                |> Enum.find_index(fn x -> x == resource end)
                |> Connection.offset_to_cursor()

              %{
                node: resource,
                cursor: cursor,
              }
          end
        end
      end
    else
      raise ArgumentError,
        """
        expected :repo and :module to be given as options. Example:
        use Heart.Relay.Connection, repo: Heart.Repo, module: Organization
        """
    end
  end

  defp get_keywords(opts) do
    {Keyword.get(opts, :repo), Keyword.get(opts, :module)}
  end

  defp verify_ecto_dep do
    unless Code.ensure_loaded?(Ecto) do
      raise "You tried to use Heart.Relay.Connection but the Ecto module " <>
        "is not loaded. Please add ecto to your dependencies."
    end
  end
end
