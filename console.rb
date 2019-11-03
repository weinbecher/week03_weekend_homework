require_relative ('models/customer')
require_relative ('models/film')
require_relative ('models/ticket')
require('pry-byebug')

Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({
  'name' => 'Nate',
  'funds' => 2000
  })

customer1.save

customer2 = Customer.new({
  'name' => 'Sophia',
  'funds' => 100
  })

customer2.save


customer3 = Customer.new({
  'name' => 'Audrey',
  'funds' => 20
  })

customer3.save

film1 = Film.new({
  'title' => 'Blade Runner 3039',
  'price' => 9
  })

film1.save

film2 = Film.new({
  'title' => 'Audrey Knows Kungfu',
  'price' => 10
  })

film2.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id })

ticket1.save


ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id })

ticket2.save


ticket3 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id })

ticket3.save


ticket4 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film2.id })

ticket4.save


binding.pry

nil
