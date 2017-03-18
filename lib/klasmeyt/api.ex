defmodule Klasmeyt.Api do
  def hasher() do
    Hashids.new([
      salt: "klasmeyt!2017",
      min_len: 6,
      alphabet: "123456789thequickbrownfoxjumpsoverthelazydog123456789"])
  end
end


