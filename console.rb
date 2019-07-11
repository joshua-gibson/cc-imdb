require_relative('models/star')
require_relative('models/casting')
require_relative('models/movie')
require('pry')

Casting.delete_all
Movie.delete_all
Star.delete_all

movie1 = Movie.new({
  'title' => 'The Matrix',
  'genre' => 'fantasy'
})
movie1.save
movie1.genre = 'sci-fi'
movie1.update

star1 = Star.new({
  'first_name' => 'Keanu',
  'last_name' => 'Reeves'
})
star1.save

casting1 = Casting.new({
  'fee' => 1_000_000,
  'movie_id' => movie1.id,
  'star_id' => star1.id
})
casting1.save

binding.pry
nil
