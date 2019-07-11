require_relative('../db/sql_runner')

class Star
  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save
    sql = "
      INSERT INTO stars (first_name, last_name)
      VALUES ($1, $2)
      RETURNING ID"
    values = [@first_name, @last_name]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    sql = "
    UPDATE stars
    SET (first_name, last_name) = ($1, $2)
    WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id_to_find)
    sql = "SELECT * FROM stars WHERE id  = $1"
    values = [id_to_find]
    result = SqlRunner.run(sql, values).first
    return Star.new(result)
  end

  def self.delete(id_to_delete)
    sql = "DELETE FROM stars WHERE id  = $1"
    values = [id_to_delete]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM stars"
    result = SqlRunner.run(sql)
    return result.map { |s| Star.new(s) }
  end
end
