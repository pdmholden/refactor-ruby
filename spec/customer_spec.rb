require 'customer'
require 'movie'
require 'rental'

shared_examples 'summary output' do
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
  let(:customer) { Customer.new("Mary")}
  let(:subject) { customer.statement }

  describe '#statement' do
    context 'when there are no rentals' do
      let(:points) { 0 }
      let(:total) { 0 }

      it_behaves_like 'summary output'
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

        it_behaves_like 'summary output'
      end

      context 'NEW_RELEASE' do
        let(:price_code) { Movie::NEW_RELEASE }
        let(:points) { 2 }
        let(:total) { 21 }

        it_behaves_like 'summary output'
      end

      context 'CHILDRENS' do
        let(:price_code) { Movie::CHILDRENS }
        let(:points) { 1 }
        let(:total) { 7.5 }

        it_behaves_like 'summary output'
      end
    end

    context 'test multiple rentals' do
      let(:regular_movie) { Movie.new("Ambush", 0) }
      let(:new_release) { Movie.new("Hunger Games", 1) }
      let(:childrens) { Movie.new("Peter Pan", 2) }
      let(:points) { 4 }
      let(:total) { 38 }

      before do
        customer.add_rental(Rental.new(regular_movie, 7))
        customer.add_rental(Rental.new(new_release, 7))
        customer.add_rental(Rental.new(childrens, 7))
      end

      it_behaves_like 'summary output'

      context 'listed output' do
        it 'outputs cost for each rental' do
          expect(subject).to match(/Ambush\t9.5/)
          expect(subject).to match(/Hunger Games\t21/)
          expect(subject).to match(/Peter Pan\t7.5/)
        end
      end
    end

    context 'edge cases' do
      let(:movie) { Movie.new("No Name", price_code) }
      let(:rental) { Rental.new(movie, days) }
      let(:points) { 1 }

      before { customer.add_rental(rental) }

      context 'REGULAR release rented for 2 day' do
        let(:days) { 2 }
        let(:price_code) { 0 }
        let(:total) { 2 }

        it_behaves_like 'summary output'
      end

      context 'NEW_RELEASE rented for 1 day' do
        let(:days) { 1 }
        let(:price_code) { 1 }
        let(:total) { 3 }

        it_behaves_like 'summary output'
      end

      context 'CHILDRENS release rented for 3 days' do
        let(:days) { 3 }
        let(:price_code) { 2 }
        let(:total) { 1.5 }

        it_behaves_like 'summary output'
      end
    end

  end
end
