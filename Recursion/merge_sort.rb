def merge_sort(arr)
  if arr.length <= 1
    return arr
  end
  m = arr.length/2
  l_half, r_half = merge_sort(arr[0..(m-1)]), merge_sort(arr[m..(arr.length-1)])
  return sorting(l_half, r_half)
end

def sorting(arr1, arr2)
  result = Array.new(0)
  i,j = 0,0
  while i < arr1.length && j < arr2.length
    if arr1[i].to_i <= arr2[j].to_i
      result.push(arr1[i])
      i+=1
    else
      result.push(arr2[j])
      j+=1
    end
  end
  if i != arr1.length
    for k in i..arr1.length
      result.push(arr1[k])
    end
  end
  if j != arr2.length
    for k in j..arr2.length
      result.push(arr2[k])
    end
  end
  return result
end

def sort(arr)
  sorted = merge_sort(arr)
  return sorted.select{|e| e != nil}
end
#test
arr = [3, 2, 1, 13, 8, 5, 0, 1]
puts sort(arr)
