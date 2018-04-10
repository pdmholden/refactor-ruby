# frozen_string_literal: true

class Customer
  attr_reader :name
  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    frequent_renter_points = 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |rental|
      # show figures for this rental
      result += "\t" + rental.movie.title + "\t" + rental.cost.to_s + "\n"

      frequent_renter_points += rental.points
    end
    # add footer lines
    result += "Amount owed is #{total_cost}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end

  def total_cost
    total_amount = 0
    @rentals.each do |rental|
      total_amount += rental.cost
    end
    total_amount
  end

end
