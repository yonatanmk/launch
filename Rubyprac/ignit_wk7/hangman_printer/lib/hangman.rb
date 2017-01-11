def puzzle(word, guesses = [])
  puzzle = ''
  word.each_char do |char|
    if guesses.include?(char)
      puzzle += "#{char} "
    else
      puzzle += "_ "
    end
  end
  return puzzle.strip
end
