require_relative('../db/sql_runner')

class Movie
  attr_reader :id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
  end

  def save
    sql = "
      INSERT INTO movies (title, genre)
      VALUES ($1, $2)
      RETURNING ID"
    values = [@title, @genre]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM movies"
    result = SqlRunner.run(sql)
    return result.map { |m| Movie.new(m) }
  end

end
