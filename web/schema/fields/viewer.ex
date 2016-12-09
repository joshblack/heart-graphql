defmodule Heart.Schema.Fields.Viewer do
  @moduledoc """
  Providers the Viewer Field for our Viewer Type.
  """

  use Absinthe.Schema.Notation

  object :viewer_field do
    field :viewer, :viewer do
      resolve fn _, _ ->
        {:ok, %{}}
      end
    end
  end
end
