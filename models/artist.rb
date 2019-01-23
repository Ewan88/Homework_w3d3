require_relative ('../db/sql_runner')

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(hash)
    @name = hash['name']
    @id = hash['id'].to_i if hash['id']
  end

  def save
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def update
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    return Artist.new(SqlRunner.run(sql, values).first)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    return SqlRunner.run(sql).map { |a| Artist.new(a) }
  end

  def albums
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map {
      |a| Album.new(a)
    }
  end

end
