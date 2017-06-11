cast = [
  %{
    character: "Buttercup",
    actor: %{
      first: "Robin",
      last:  "Wright"
    },
    role: "princess"
  },
  %{
    character: "westley",
    actor: %{
      first: "Cary",
      last:  "Ewles" # typo!
    },
    role: "farm boy"
  }
]

IO.inspect get_in(cast, [Access.all(), :character])
# ["Buttercup", "westley"]
IO.inspect get_in(cast, [Access.at(1), :character])
# "farm boy"
IO.inspect get_and_update_in(cast, [Access.all(), :actor, :last],
                             fn (val) -> { val, String.upcase(val)} end)
# {["Wright", "Ewles"],
# [%{actor: %{first: "Robin", last: "WRIGHT"}, character: "Buttercup",
#    role: "princess"},
#  %{actor: %{first: "Cary", last: "EWLES"}, character: "westley",
#    role: "farm boy"}]}
