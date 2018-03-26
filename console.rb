require_relative( 'models/ticket.rb' )
require_relative( 'models/customer.rb' )
require_relative( 'models/film.rb' )

Customer.delete_all()


customer1 = Customer.new({'name' => 'Kara', 'funds' => 500.00})
customer1.save()

customer2 = Customer.new({'name' => 'Stacy', 'funds' => 300.00})
customer2.save()

customer3 = Customer.new({'name' => 'Jessica', 'funds' => 100.00})
customer3.save()

customer4 = Customer.new({'name' => 'Amber', 'funds' => 20.00})
customer4.save()
