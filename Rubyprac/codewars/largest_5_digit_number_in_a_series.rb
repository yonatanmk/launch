# In the following 6 digit number:
# 283910
#
# 91 is the greatest sequence of 2 digits.
#
# Complete the solution so that it returns the largest five digit number found
# within the number given.. The number will be passed in as a string of only
# digits. It should return a five digit integer. The number passed may be as large
# as 1000 digits.

def solution(digits)
  number_list = []
  digits = digits.split("")
  (0..digits.length - 5).each do |x|
    number_list << [digits[x], digits[x+1], digits[x+2], digits[x+3], digits[x+4]].join("").to_i
  end
  return number_list.max
end

#top voted
def solution(digits)
  digits.split('').each_cons(5).max.join.to_i
end

def solution(digits)
  digits.scan(/\d{5}/).max.to_i
end

puts solution("123456285927293599999235235235")
