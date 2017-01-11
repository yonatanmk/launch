# A string is considered to be in title case if each word in the string is either
# (a) capitalised (that is, only the first letter of the word is in upper case)
# or (b) considered to be an exception and put entirely into lower case unless
# it is the first word, which is always capitalised.
#
# Write a function that will convert a string into title case, given an optional
# list of exceptions (minor words). The list of minor words will be given as a
# string with each word separated by a space. Your function should ignore the
# case of the minor words string -- it should behave in the same way even if the
# case of the minor word string is changed.
#
# Arguments (Haskell)
#
# First argument: space-delimited list of minor words that must always be
# lowercase except for the first word in the string.
#
# Second argument: the original string to be converted.
# Arguments (Other languages)
#
# First argument (required): the original string to be converted.
# Second argument (optional): space-delimited list of minor words that must always
# be lowercase except for the first word in the string.
# The JavaScript/CoffeeScript tests will pass undefined when this argument is unused.

# Test.assert_equals(title_case(''), '')
# Test.assert_equals(title_case('a clash of KINGS', 'a an the of'), 'A Clash of Kings')
# Test.assert_equals(title_case('THE WIND IN THE WILLOWS', 'The In'), 'The Wind in the Willows')
# Test.assert_equals(title_case('the quick brown fox'), 'The Quick Brown Fox')

def title_case(title, minor_words = nil)
  title = title.downcase.split(" ")
  title.map! {|word| minor_words && minor_words.downcase.split(" ").include?(word) ? word : word.capitalize}
  title[0] = title[0].capitalize if title[0]
  return title.join(" ")
end

def title_case(title, minor_words = nil)
  return title.downcase.split(" ").map!.with_index {|word, index| minor_words && index > 0 && minor_words.downcase.split(" ").include?(word) ? word : word.capitalize}.join(" ")
end

#top voted
def title_case(title, minor_words = '')
  title.capitalize.split().map{|a| minor_words.downcase.split().include?(a) ? a : a.capitalize}.join(' ')
end

puts title_case('')#, '')
puts title_case('', 'the')#, '')
puts title_case('a clash of KINGS', 'a an the of')#, 'A Clash of Kings')
puts title_case('THE WIND IN THE WILLOWS', 'The In')#, 'The Wind in the Willows')
puts title_case('the quick brown fox')#, 'The Quick Brown Fox')
