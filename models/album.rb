require_relative('../db/sql_runner')

class Album

  attr_accessor :title, :genre
  attr_reader :artist_id, :id

  def initialize(hash)
    @title = hash['title']
    @genre = hash['genre']
    @artist_id = hash['artist_id'].to_i
    @id = hash['id'].to_i if hash['id']
  end

  def save
    sql = "INSERT INTO albums (title, genre, artist_id)
          VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def update
    sql = "UPDATE albums SET (
    title,
    genre,
    artist_id
    ) = ( $1, $2, $3 ) WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    return Album.new(SqlRunner.run(sql, values).first)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    return SqlRunner.run(sql).map { |a| Album.new(a) }
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    return Artist.new(SqlRunner.run(sql, values).first)
  end

end
