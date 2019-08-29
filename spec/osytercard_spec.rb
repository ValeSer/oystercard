require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to :top_up }

  it "has a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  it 'increases the balance' do
    expect { subject.top_up(1) }.to change {subject.balance }.from(0).to(subject.balance+1)
  end

  it 'raises error when the limit is exceeded' do

     # subject.top_up(91)
    expect { subject.top_up(91) }.to raise_error ("top up limit of #{Oystercard::LIMIT} reached")
  end

  it 'deducts money'
  expect { subject.deduct(90) }.to change {subject.balance }.from(90).to(subject.balance-1)

end
