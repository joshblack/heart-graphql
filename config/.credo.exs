%{
  configs: [
    %{
      # Run any config using `mix credo -C <name>`. If no config name is given
      # "default" is used.
      name: "default",
      #
      # These are the files included in the analysis:
      files: %{
        #
        # You can give explicit globs or simply directories.
        # In the latter case `**/*.{ex,exs}` will be used.
        included: ["lib/", "src/", "web/", "apps/"],
        excluded: [~r"/_build/", ~r"/deps/"]
      },
      checks: [
        # You can also customize the exit_status of each check.
        # If you don't want TODO comments to cause `mix credo` to fail, just
        # set this value to 0 (zero).
        {Credo.Check.Design.TagTODO, exit_status: 0},
      ],
    },
  ],
}
