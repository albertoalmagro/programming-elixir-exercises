# Convert a float to a string with two decimal digits (Erlang)
:io.format("~4.2f~n", [3.145])

# Get the value of an operating-system environment variable. (Elixir)
System.get_env("PATH")

# Return the extension component of a file name (so return .exs if given
# "davee/test.exs"). (Elixir)

Regex.run(~r/\.\w*/, "davee/test.exs")

# Return the process's current working directory. (Elixir)
System.cwd()

# Convert a string containing JSON into Elixir data structures. (Just find; don't install)
# https://github.com/devinus/poison

# Execute a commnad in your operating system's shell.
System.cmd "echo", ["hello world!"]
