desc "ALL OF THE PORKOCHUs"
task :spawn => :environment do
  puts "Breading the pokemans..."
  Pokemon.spawn
  puts "YOU MONSTER!"
end
