# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first) movies =

being_mortal = Book.create(title: "Being Mortal", author: "Atul Gawande", isbn: "5555555555555")
los_cocuyos = Book.create(title: "The Prince of Los Cocuyos", author: "Richard Blanco", isbn: "5555555555555")
never_let = Book.create(title: "NEver Let Me Go", author: "Ishiguro Kazuo", isbn: "5555555555555")
thousand_splendid = Book.create(title: "A Thousand Splendid Suns", author: "Khaled Hosseini", isbn: "5555555555555")
bad_feminist = Book.create(title: "Bad Feminist", author: "Roxane Gay", isbn: "5555555555555")
just_mercy = Book.create(title: "Just Mercy", author: "Bryan Stevenson", isbn: "5555555555555")
citizen = Book.create(title: "Citizen", author: "Claudia Rankine", isbn: "5555555555555")
world_and_me = Book.create(title: "Between the World and Me", author: "Ta-Nehisi Coates", isbn: "5555555555555")
breath_air = Book.create(title: "When Breath Becomes Air", author: "Paul Kalanithi", isbn: "5555555555555")
cup_of_water = Book.create(title: "A Cup of Water Under My Bed", author: "Daisy Hernandez", isbn: "5555555555555")
indigenous_peoples = Book.create(title: "An Indigenous Peoples' History of the United States", author: "Roxanne Dunbar-Ortiz", isbn: "5555555555555")

review_1 = Review.create(rating: 5, body:"Not so much a history of the Indigenous Peoples of North America as much as a re-telling of American history that actually includes their unfortunate role within it, which is way more prominent in ways you haven't imagined.
This is a succinct, powerful read whose basic premise, the US is a settler-colonial power, screams at you throughout.", book: indigenous_peoples)

review_2 = Review.create(rating: 4, body: "Found a lot to relate to in this lyrical and poignant collection of stories by Daisy Hernandez. Hernandez weaves multiple narrative strands together: stories of her parents' and their siblings emigration from Colombia and Cuba; of the ravages of colonialism on language, culture, and community; of compromise, negotiation, and syncretism between the faith and culture of the colonizers and the beliefs and traditions slaves brought with them to the Americas and transformed (often by necessity)", book: cup_of_water)

review_3 = Review.create(rating: 5, body:"This book is necessary and timely. It was timely fifty years ago. I pray it is not timely fifty years from now. Rankine takes on the realities of race in America with elegance but also rage/resignation... maybe we call it rageignation.", book: citizen)

review_4 = Review.create(rating: 3, body: "I loved this novel not so much for its gothic darkness, but for the questions it raised. It seems chillingly plausible that any cruelty, carried on long enough, will be accepted as the norm by humanity-especially if it benefits the majority", book: never_let)

review_5 = Review.create(rating: 4, body: "I loved The Kite Runner, but A Thousand Splendid Suns is even better. This book is described as breathtaking, and I have to say that is a teensy bit of an understatement.

There were times, reading this, when I literally couldn't breathe, and felt like the bottom had dropped out of my stomach. But this story is beautiful, and enlightening and hopeful even through all the gritty, heart-wrenching, almost physically painful emotional rawness of it.", book: thousand_splendid)

review_6 = Review.create(rating: 5, body: " Fabulous. Great read. So much I could relate to, but also so much that I'd never thought about. I didn't agree with all of it, but I don't need to agree to grow and learn from an opinion. My only complaint is that it wasn't longer. I wanted more more more. Thumbs up.", book: bad_feminist)
