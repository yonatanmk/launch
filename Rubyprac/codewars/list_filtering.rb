# In this kata you will create a function that takes a list of non-negative
# integers and strings and returns a new list with the strings filtered out.

# Test.assert_equals(filter_list([1,2,'a','b']),[1,2])
# Test.assert_equals(filter_list([1,'a','b',0,15]),[1,0,15])
# Test.assert_equals(filter_list([1,2,'aasf','1','123',123]),[1,2,123])

def filter_list(l)
  return l.select {|x| x.class == Fixnum}
end

def filter_list2(l)
  return l.delete_if {|x| x.class != Fixnum}
end

print filter_list([1,2,'a','b'])#,[1,2])
puts
print filter_list([1,'a','b',0,15])#,[1,0,15])
puts
print filter_list([1,2,'aasf','1','123',123])#,[1,2,123])
puts
puts

print filter_list2([1,2,'a','b'])#,[1,2])
puts
print filter_list2([1,'a','b',0,15])#,[1,0,15])
puts
print filter_list2([1,2,'aasf','1','123',123])#,[1,2,123])
puts
puts
