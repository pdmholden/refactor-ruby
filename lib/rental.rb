# frozen_string_literal: true

class Rental
  attr_reader :movie, :days_rented
  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end

  def cost
    amount = 0
    case movie.price_code
    when Movie::REGULAR
      amount += 2
      amount += (days_rented - 2) * 1.5 if days_rented > 2
    when Movie::NEW_RELEASE
      amount += days_rented * 3
    when Movie::CHILDRENS
      amount += 1.5
      amount += (days_rented - 3) * 1.5 if days_rented > 3
    end
    amount
  end
end
