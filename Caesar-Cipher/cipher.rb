def Cipher (str,num) 
    arr = str.split('')
    arr2 = []
    arr.each do |item|
        if "a"<=item and item<="z"
            chrOld = item.ord - 97
            chrNew = (chrOld+num)%26 + 97
            arr2.push(chrNew.chr)
        elsif "A"<=item and item<="Z"
            chrOld = item.ord - 63
            chrNew = (chrOld+num)%26 + 63
            arr2.push(chrNew.chr)
        else arr2.push(item)
        end
    end
    return arr2.join('')
end

puts Cipher("What a string!", 5)