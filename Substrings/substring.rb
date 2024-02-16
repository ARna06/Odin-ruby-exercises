dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substring(string, dictionary) 
    str = string.downcase
    container = dictionary.reduce(Hash.new(0)) do |obj, item|
        if str.include?(item)
            obj[item] +=1
        end
        obj
    end
    return container
end

puts substring("Howdy partner, sit down! How's it going?", dictionary)
puts substring("below", dictionary)