require_relative('../db/sql_runner.rb')

class Screening
  attr_reader :id
  attr_accessor :film_time, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_time = options['film_time']
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (film_time, film_id) VALUES($1, $2) RETURNING id"
    values = [@film_time, @film_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end





  # - Limit the available tickets for screenings.


end
