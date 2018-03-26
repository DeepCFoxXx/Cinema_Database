require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_f
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING *"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers
    SET
    (
    name, funds
    ) =
    (
    $1, $2
    )
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN screenings
    ON films.id = screenings.film_id
    INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return Film.map_items(film_data)
  end

  def number_of_tickets_bought()
    return films().count
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customer_data = SqlRunner.run(sql, values)
    return Customer.map_items(customer_data)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def Customer.map_items(customer_data)
    result = customer_data.map { |customer| Customer.new( customer ) }
    return result
  end

  def self.map_item(customer_data)
    result = Customer.map_items(customer_data)
    return result.first
  end

end
