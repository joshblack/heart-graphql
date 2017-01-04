defmodule Heart.EventTest do
  use Heart.ModelCase

  alias Heart.Event

  @valid_attrs %{name: "some content", value: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
