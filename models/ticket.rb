require_relative('../db/sql_runner.rb')

class Ticket

attr_reader :id
attr_accessor :customer_id, :film_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @customer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
end

def save()
  sql = "INSERT INTO tickets (customer_id, film_id) VALUES($1, $2) RETURNING id"
  values = [@customer_id, @film_id]
  ticket = SqlRunner.run(sql, values).first
  @id = ticket['id'].to_i
end

def update()
  sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end

def film()
  sql = "SELECT * From films WHERE id = $1"
  values = [@film_id]
  film = SqlRunner.run(sql, values).first
  return Film.new(film)
end

# difference between?
# => {"id"=>"45", "title"=>"Blade Runner 3039", "price"=>"9"}

# => #<Film:0x007fb377ba3d30 @id=47, @price=9, @title="Blade Runner 3039">

def customer()
  sql = "SELECT * from customers where id = $1"
  values = [@customer_id]
  customer = SqlRunner.run(sql, values).first
  return Customer.new(customer)
end



def delete()
  sql = "DELETE FROM tickets WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end


def self.all()
  sql = "SELECT * FROM tickets"
  ticket_data = SqlRunner.run(sql)
  return Ticket.map_items(ticket_data)
end


def self.delete_all()
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end


def self.map_items(data)
  result = data.map{|ticket| Ticket.new(ticket)}
  return result
end

end
