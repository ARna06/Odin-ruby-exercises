def lesser (a, b)
    if a<b 
        return true
    else
        return false
    end
end

def sort(arr)
    for i in 0...arr.length
        for j in 0...(arr.length-1)
            if !lesser(arr[j], arr[j+1])
                d = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = d
            end
        end
    end
    return arr 
end

arr = [4,3,78,2,0,2]
puts sort(arr)