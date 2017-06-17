defmodule MyString do
  def center(words) do
    max_length = max_word_length(words)

    words
    |> Enum.map(&(pretty_print(&1, max_length)))
    |> Enum.each(&IO.puts/1)
  end

  defp max_word_length(words), do: Enum.max_by(words, &String.length/1) |> String.length

  defp pretty_print(word, len) do
    word_length  = String.length(word)
    whitespaces  = len - String.length(word)
    leading_pad  = word_length + div(whitespaces, 2)
    trailing_pad = leading_pad + div(whitespaces, 2) + rem(whitespaces, 2)

    word
    |> String.pad_leading(leading_pad)
    |> String.pad_trailing(trailing_pad)
  end
end
