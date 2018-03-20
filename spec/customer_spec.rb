require 'customer'
require 'movie'
require 'rental'

shared_examples "summary output" do
  it 'shows total correctly' do
    result_match = "Amount owed is #{total}"
    expect(subject).to match(result_match)
  end

  it 'shows points correctly' do
    result_match = "You earned #{points}"
    expect(subject).to match(result_match)
  end
end

describe Customer do
  let(:customer) { Customer.new("Peter")}
  let(:subject) { customer.statement }

  describe '#statement' do
    context 'when there are no rentals' do
      let(:points) { 0 }
      let(:total) { 0 }

      it_behaves_like "summary output"
    end

    context 'testing rental types separately' do
      let(:movie) { Movie.new("Peter Pan", price_code) }
      let(:rental) { Rental.new(movie, 7) }

      before do
        customer.add_rental(rental)
      end

      context 'REGULAR' do
        let(:price_code) { Movie::REGULAR }
        let(:points) { 1 }
        let(:total) { 9.5 }

        it_behaves_like "summary output"
      end

      context 'NEW_RELEASE' do
        let(:price_code) { Movie::NEW_RELEASE }
        let(:points) { 2 }
        let(:total) { 21 }

        it_behaves_like "summary output"
      end

      context 'CHILDRENS' do
        let(:price_code) { Movie::CHILDRENS }
        let(:points) { 1 }
        let(:total) { 7.5 }

        it_behaves_like "summary output"
      end
    end

  end
end
