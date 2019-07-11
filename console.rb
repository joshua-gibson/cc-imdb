require_relative('models/star')
require_relative('models/casting')
require_relative('models/movie')
require('pry')

Casting.delete_all
Movie.delete_all
Star.delete_all

movie1 = Movie.new({
  'title' => 'The Matrix',
  'genre' => 'fantasy',
  'budget' => 63_000_000
})

movie2 = Movie.new({
  'title' => 'Point Break',
  'genre' => 'action',
  'budget' => 105_000_000
})

movie3 = Movie.new({
  'title' => 'Die Hard',
  'genre' => 'action',
  'budget' => 28_000_000
})


movie1.save
movie2.save
movie3.save
movie1.genre = 'sci-fi'
movie1.update

star1 = Star.new({
  'first_name' => 'Keanu',
  'last_name' => 'Reeves'
})
star2 = Star.new({
  'first_name' => 'Bruce',
  'last_name' => 'Willis'
})
star1.save
star2.save

casting1 = Casting.new({
  'fee' => 1_000_000,
  'movie_id' => movie1.id,
  'star_id' => star1.id
})
casting2 = Casting.new({
  'fee' => 500_000,
  'movie_id' => movie2.id,
  'star_id' => star1.id
})
casting3 = Casting.new({
  'fee' => 750_000,
  'movie_id' => movie3.id,
  'star_id' => star2.id
})
casting1.save
casting2.save
casting3.save

binding.pry
nil
