#by iterative method
def fibonacci_iter(number)
  if number<1
    return "Insert a valid number"
  end
  container = Array.new(0)
  num0 , num1 = 0, 1
  container.push(num0)
  container.push(num1)
  iter = 1
  while iter <= number-2
    temp = num0
    num0 = num1
    num1 = temp + num0
    container.push(num1)
    iter +=1
  end
  return container
end

#by recursion
def fibonacci_recur(number)
  case number
  when 0
    return 0
  when 1
    return 1
  else
    return fibonacci_recur(number-1) + fibonacci_recur(number-2)
  end
end

def fibonacci_recur_list(num)
  if num < 0
    return "Insert a valid number!"
  end
  container = Array.new(0)
  i = 0
  while i<num
    container.push(fibonacci_recur(i))
    i += 1
  end
  return container
end
