require_relative('../db/sql_runner')

class Movie
  attr_reader :id
  attr_accessor :title, :genre, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget'].to_i
  end

  def save
    sql = "
      INSERT INTO movies (title, genre, budget)
      VALUES ($1, $2, $3)
      RETURNING ID"
    values = [@title, @genre, @budget]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    sql = "
    UPDATE movies
    SET (title, genre, budget) = ($1, $2, $3)
    WHERE id = $4"
    values = [@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def stars
    sql = "SELECT s.*
           FROM stars s
           INNER JOIN castings c
             ON s.id = c.star_id
          WHERE c.movie_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|star| Star.new(star) }
  end

  def budget
    sql="SELECT m.budget - SUM(c.fee) AS new_budget
          FROM movies m
          INNER JOIN castings c
            ON m.id = c.movie_id
          WHERE c.movie_id = $1
          GROUP BY m.id"
    values = [@id]
    return SqlRunner.run(sql, values).first['new_budget'].to_i
  end

  def self.find(id_to_find)
    sql = "SELECT * FROM movies WHERE id  = $1"
    values = [id_to_find]
    result = SqlRunner.run(sql, values).first
    return Movie.new(result)
  end

  def self.delete(id_to_delete)
    sql = "DELETE FROM movies WHERE id  = $1"
    values = [id_to_delete]
    SqlRunner.run(sql, values)
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
