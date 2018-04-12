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
    end

    # add footer lines
    result += "Amount owed is #{total_cost}\n"
    result += "You earned #{total_points} frequent renter points"
    result
  end

  def html_statement
    result = "<h1>Rentals for <em>#{@name}</em></h1><p>\n"
		@rentals.each do |element|
			# show figures for this rental
			result += "\t" + element.movie.title + ": " + element.cost.to_s + "<br>\n"
		end
		# add footer lines
		result += "<p>Amount owed <em>#{total_cost}</em></p>\n"
		result += "<p>You earned " +
							"<em>#{total_points}</em> " +
							"frequent renter points</p>"
		result
  end

  def total_cost
    @rentals.inject(0) { |memo, r| memo += r.cost }
  end

  def total_points
    @rentals.inject(0) { |memo, r| memo += r.points }
  end

end
