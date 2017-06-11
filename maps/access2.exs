cast = [
  %{
    character: "Buttercup",
    actor: { "Robin", "Wright" },
    role: "princess"
  },
  %{
    character: "westley",
    actor: { "Cary", "Elwes" },
    role: "farm boy"
  }
]

IO.inspect get_in(cast, [Access.all(), :actor, Access.elem(1)])
# ["Wright", "Elwes"]
IO.inspect get_and_update_in(cast, [Access.all(), :actor, Access.elem(1)],
                             fn (val) -> {val, String.reverse(val)} end)
# {["Wright", "Elwes"],
#  [%{actor: {"Robin", "thgirW"}, character: "Buttercup", role: "princess"},
#   %{actor: {"Cary", "sewlE"}, character: "westley", role: "farm boy"}]}
