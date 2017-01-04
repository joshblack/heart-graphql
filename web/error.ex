defmodule Heart.Error do
  def not_found(type: type, id: id) do
    """
    No resource found of type: `#{type}`, with id: `#{id}`.
    """
  end

  def not_found(type: type, slug: slug) do
    """
    No resource found of type: `#{type}`, with slug: `#{slug}`.
    """
  end

  def format(changeset) do
    Enum.map(changeset.errors, fn {field, detail} ->
      %{
        source: field,
        title: "Invalid Attribute",
        detail: render_detail(detail)
      }
    end)
  end

  def render_detail({message, values}) do
    Enum.reduce values, message, fn {k, v}, acc ->
      String.replace(acc, "%{#{k}}", to_string(v))
    end
  end

  def render_detail(message) do
    message
  end
end
