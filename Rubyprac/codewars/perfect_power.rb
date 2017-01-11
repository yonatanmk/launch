# A perfect power is a classification of positive integers:
#
# In mathematics, a perfect power is a positive integer that can be expressed
# as an integer power of another positive integer. More formally, n is a perfect
# power if there exist natural numbers m > 1, and k > 1 such that mk = n.
# Your task is to check wheter a given integer is a perfect power. If it is a
# perfect power, return a pair m and k with mk = n as a proof. Otherwise
# return Nothing, Nil, null, None or your language's equivalent.
#
# Note: For a perfect power, there might be several pairs.
# For example 81 = 3^4 = 9^2, so (3,4) and (9,2) are valid solutions.
# However, the tests take care of this, so if a number is a perfect power, return
# any pair that proves it.
#
# Examples
# isPP(4) => [2,2]
# isPP(9) => [3,2]
# isPP(5) => nil

# describe "isPP" do
#     it "should work for some small numbers" do
#       Test.assert_equals(isPP(4), [2,2], "4 = 2^2")
#       Test.assert_equals(isPP(8), [2,3], "8 = 2^3")
#       Test.assert_equals(isPP(36), [6,2], "36 = 6^2")
#       Test.assert_equals(isPP(9), [3, 2], "9 = 3^2")
#       Test.assert_equals(isPP(5), nil, "5 is not perfect")
#     end
#     it "should return valid pairs for random inputs" do
#         i = 0
#         while (i < 20) do
#             a = rand(1000..65000)
#             #puts a
#             r = isPP(a)
#             if ((r != nil) && (r[0] ** r[1] != a)) then
#                 Test.assert_equals(r, a, "your pair [#{r[0]}, #{r[1]}] doesn't work for #{a}")
#                 break
#             end
#             i += 1
#         end
#     end
# end

def isPP(n)
  (0..Math.sqrt(n).floor).each do |base_num|
    (0..n).each do |exponent|
      return [base_num, exponent] if base_num**exponent == n
    end
  end
  return nil
end

#top voted
def isPP(n)
  (2..(n ** 0.5)).each do |m|
    k = (Math.log(n) / Math.log(m)).round
    if m ** k == n then
      return [m, k]
    end
  end
  return nil
end

print isPP(4)#, [2,2], "4 = 2^2")
puts
print isPP(8)#, [2,3], "8 = 2^3")
puts
print isPP(36)#, [6,2], "36 = 6^2")
puts
print isPP(9)#, [3, 2], "9 = 3^2")
puts
print isPP(5)#, nil, "5 is not perfect")
