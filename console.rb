require_relative('models/star')
require_relative('models/casting')
require_relative('models/movie')
require('pry')

Casting.delete_all
Movie.delete_all
Star.delete_all

movie1 = Movie.new({
  'title' => 'The Matrix',
  'genre' => 'sci-fi'
})

star1 = Star.new({
  'first_name' => 'Keanu',
  'last_name' => 'Reeves'
})

casting1 = Casting.new({
  'fee' => 1_000_000,
  'movie_id' => movie1.id,
  'star_id' => star1.id,
})

binding.pry
nil
