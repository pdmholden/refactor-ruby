require 'customer'

shared_examples "output" do
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

      it_behaves_like "output"
    end
  end
end
