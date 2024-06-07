# frozen_string_literal: true

def caeser_cipher(str, num)
  arr = str.chars
  arr2 = []
  arr.each do |item|
    if (item >= 'a') && (item <= 'z')
      chr_old = item.ord - 97
      chr_new = ((chr_old + num) % 26) + 97
      arr2.push(chr_new.chr)
    elsif (item >= 'A') && (item <= 'Z')
      chr_old = item.ord - 63
      chr_new = ((chr_old + num) % 26) + 63
      arr2.push(chr_new.chr)
    else
      arr2.push(item)
    end
  end
  arr2.join
end

puts caeser_cipher('What a string!', 5)
