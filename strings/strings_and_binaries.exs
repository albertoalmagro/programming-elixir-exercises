defmodule StringsAndBinaries do

  def ascii_printable_only?([]), do: true
  def ascii_printable_only?([ digit | tail] ) do
    printable?(digit) && ascii_printable_only?(tail)
  end

  defp printable?(chr) when chr in 32..126, do: true
  defp printable?(_), do: false

  def anagram?([], []),     do: true
  def anagram?([], _word2), do: false
  def anagram?(_word1, []), do: false
  def anagram?(word1, word2) when length(word1) !== length(word2), do: false
  def anagram?([ chr | tail] , word2) do
    { chr_in_word?, remaining } = remove_char_in_word(chr, word2, [])
    if chr_in_word? do
      anagram?(tail, remaining)
    else
      false
    end
  end

  defp remove_char_in_word(_chr, [], []), do: { true, [] }
  defp remove_char_in_word(_chr, [], _remaining), do: { false, [] }
  defp remove_char_in_word(chr, [ head | tail ], remaining) when chr === head do
   { true, remaining ++ tail }
  end
  defp remove_char_in_word(chr, [ head | tail ], remaining) do
    remove_char_in_word(chr, tail, [ head | remaining ])
  end

  def calculate(expression) do
    { n1, rest } = parse_number(expression)
    rest         = skip_spaces(rest)
    { op, rest } = parse_operator(rest)
    rest         = skip_spaces(rest)
    { n2, [] }   = parse_number(rest)
    op.(n1, n2)
  end

  defp parse_number(expression), do: _parse_number({ 0, expression })

  defp _parse_number({value, [ digit | rest ] }) when digit in ?0..?9 do
    _parse_number({ value*10 + digit - ?0, rest})
  end

  defp _parse_number(result), do: result


  defp skip_spaces([ ?\s  | rest ]), do: skip_spaces(rest)
  defp skip_spaces(rest),          do: rest

  defp parse_operator([ ?+ | rest ]), do: { &(&1+&2), rest }
  defp parse_operator([ ?- | rest ]), do: { &(&1-&2), rest }
  defp parse_operator([ ?* | rest ]), do: { &(&1*&2), rest }
  defp parse_operator([ ?/ | rest ]), do: { &(div(&1, &2)), rest }
end
