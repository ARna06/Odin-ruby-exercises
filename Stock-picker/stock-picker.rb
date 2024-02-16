price = [17,3,6,9,15,8,6,1,10]

def best_decision(arr) 
    
    container = [] 
    for i in (0...arr.length-1) do
        arr_var = []
        for j in (i+1...arr.length) do
            arr_var[j-i-1] = arr[i] - arr[j]
        end 
        container[i] = arr_var;
    end

    k = 0
    dat = container.reduce(Array.new(0)) do |arr_n, item|
        arr_n[k] = [item.min, item.find_index(item.min)]
        k += 1
        arr_n
    end
    new_arr = []
    dat.each do |item|
        new_arr.push(item[0])
    end
    i = new_arr.find_index(new_arr.min)
    j = i + dat[i][1] + 1

    return ([i,j])
end

puts best_decision(price)