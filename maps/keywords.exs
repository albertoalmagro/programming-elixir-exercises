defmodule Canvas do

  @defaults [ fg: "black", bg: "white", font: "Merriweather" ]

  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts "Drawings text #{inspect(text)}"
    IO.puts "Foreground:   #{options[:fg]}" #Access kwlist[key]
    IO.puts "Background:   #{Keyword.get(options, :bg)}" # Access
    IO.puts "Font:         #{Keyword.get(options, :font)}"
    IO.puts "Pattern:      #{Keyword.get(options, :pattern, "solid")}" # Default value
    IO.puts "Style:        #{inspect Keyword.get_values(options, :style)}" # Multiple keys
  end
end

Canvas.draw_text("hello", fg: "red", style: "italic", style: "bold")
