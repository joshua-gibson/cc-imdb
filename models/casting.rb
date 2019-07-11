require_relative('../db/sql_runner')

class Casting
  attr_reader :id, :movie_id, :star_id
  attr_accessor :fee

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @star_id = options['star_id'].to_i
    @fee = options['id'].to_i
  end

  def save
    sql = "
      INSERT INTO castings (movie_id, star_id)
      VALUES ($1, $2)
      RETURNING ID"
    values = [@movie_id, @star_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    sql = "
    UPDATE castings
    SET (movie_id, star_id) = ($1, $2)
    WHERE id = $3"
    values = [@movie_id, @star_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id_to_find)
    sql = "SELECT * FROM castings WHERE id  = $1"
    values = [id_to_find]
    result = SqlRunner.run(sql, values).first
    return Casting.new(result)
  end

  def self.delete(id_to_delete)
    sql = "DELETE FROM castings WHERE id  = $1"
    values = [id_to_delete]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM castings"
    result = SqlRunner.run(sql)
    return result.map { |c| Casting.new(c) }
  end
end
