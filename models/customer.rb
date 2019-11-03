require_relative('../db/sql_runner.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name , @funds, @id]
    SqlRunner.run(sql, values)
  end


  # which customers are coming to see one film

  def film()
    sql = "SELECT films.* From films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1 "
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    Film.map_items(film_data)
    # why not just select * from custmoers
  end



#  Buying tickets should decrease the funds of the customer by the price

  def buy_ticket
    films = self.film()
    film_price = films.map{|film| film.price}
    combined_film_price = film_price.sum
    return @funds - combined_film_price
  end

# Check how many tickets were bought by a customer
  def ticket_count
    films = self.film()
    films.count
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    return Customer.map(customer_data)
  end

  def self.map_items(data)
    result = data.map{|customer| Customer.new(customer)}
    return result
  end


end
