defmodule Klasmeyt.Api do
  def generate_terms(title, short_desc) do
    "#{title} #{short_desc}"
    |> String.downcase
    |> String.split
    |> Enum.sort
    |> Enum.dedup
  end

  def hasher() do
    Hashids.new([salt: "klasmeyt!2017", min_len: 6, alphabet: "123456789thequickbrownfoxjumpsoverthelazydog123456789"])
  end
end


