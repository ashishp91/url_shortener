class Base62
  ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".freeze
  BASE = ALPHABET.length
  BUFFER = 0

  class << self

    def encode(num)
      return ALPHABET[0] if num == 0 || num.nil?

      num += BUFFER
      encoded_str = ""

      while num > 0 do
        encoded_str = ALPHABET[num%BASE] + encoded_str
        num /= BASE
      end

      encoded_str
    end

    def decode(str)
      num = 0

      str.reverse.each_char.with_index do |ch, pos|
        power = BASE**pos
        index = ALPHABET.index(ch)
        num += index * power
      end

      num - BUFFER
    end

  end
end
