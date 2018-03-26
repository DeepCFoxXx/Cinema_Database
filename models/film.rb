require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id, :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_f
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING *"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    customers = Customer.map_items(customer_data)
    return customers
  end

  def number_of_viewers()
    return customers.count
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    film_data = SqlRunner.run(sql, values)
    return Film.map_items(film_data)
  end

  def self.most_viewers()
    ordered = Film.all.sort! { |film1,film2| film1.number_of_viewers <=> film2.number_of_viewers }
    return ordered.first
  end

  def Film.map_items(film_data)
    result = film_data.map { |film| Film.new( film ) }
    return result
  end

  def Film.map_item(film_data)
    result = Film.map_items(film_data)
    return result.first
  end

end
