# Take an integer n (n >= 0) and a digit d (0 <= d <= 9) as an integer.
# Square all numbers k (0 <= k <= n) between 0 and n. Count the numbers
# of digits d used in the writing of all the k**2. Call nb_dig (or nbDig
# or ...) the function taking n and d as parameters and returning this count.

def nb_dig(n, d)
  Array(0..n).map!{|x| (x**2).to_s}.join("").split("").select{|x| x == d.to_s}.length
end

puts nb_dig(5750, 0)#, 4700)
