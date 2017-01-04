defmodule Heart.Schema.Types.Enums do
  @moduledoc """
  """

  use Heart.Web, :type

  @desc "Specify how you want to sort the collection"
  enum :SORT do
    @desc "Sort the collection by ascending order."
    value :asc

    @desc "Sort the collection by descending order."
    value :desc
  end

  enum :ORDER_BY do
    @desc "Order by when the resource was created."
    value :inserted_at
  end
end
