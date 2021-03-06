defmodule Heart.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Heart.Web, :controller
      use Heart.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id

      defp slugify_name(changeset) do
        if name = get_change(changeset, :name) do
          put_change(changeset, :slug, Slugger.slugify_downcase(name))
        else
          changeset
        end
      end

      defp slugify_title(changeset) do
        if title = get_change(changeset, :title) do
          put_change(changeset, :slug, Slugger.slugify_downcase(title))
        else
          changeset
        end
      end
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Heart.Repo
      import Ecto
      import Ecto.Query

      import Heart.Router.Helpers
      import Heart.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      import Heart.Router.Helpers
      import Heart.ErrorHelpers
      import Heart.Gettext
    end
  end

  def type do
    quote do
      # Provides us with a DSL for defining GraphQL Types
      use Absinthe.Schema.Notation
      use Absinthe.Relay.Schema.Notation

      # Enable helpers for batching associated requests
      use Absinthe.Ecto, repo: Heart.Repo
    end
  end

  def resolver do
    quote do
      alias Heart.Repo
      import Ecto
      import Ecto.Query
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Heart.Repo
      import Ecto
      import Ecto.Query
      import Heart.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
