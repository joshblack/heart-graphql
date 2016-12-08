# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Heart.Repo.insert!(%Heart.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Heart.Organization
alias Heart.Offering
alias Heart.Repo

org1 = Repo.insert!(%Organization{name: "IBM Watson", description: "An organization in IBM"})
org2 = Repo.insert!(%Organization{name: "IBM Analytics", description: "An organization in IBM"})

for _ <- 1..10 do
  Repo.insert!(%Offering{
    name: Faker.Company.name,
    description: Faker.Lorem.sentence,
    organization_id: [org1.id, org2.id] |> Enum.take_random(1) |> hd
  })
end
