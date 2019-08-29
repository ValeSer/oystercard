require 'oystercard'

describe Oystercard do

  context '#initialize a new card' do
    it { is_expected.to respond_to :top_up }
    it { is_expected.to respond_to :deduct }
  end

  context '#top_up' do
    it "has a balance of zero" do
      expect(subject.balance).to eq(0)
    end

    it 'increases the balance' do
      expect { subject.top_up(1) }.to change {subject.balance }.from(0).to(subject.balance+1)
    end

    it 'raises error when the limit is exceeded' do
      expect { subject.top_up(91) }.to raise_error (Oystercard::ERROR_LIMIT_EXCEEDED)
    end
  end

  context '#deduct' do
    it 'deducts money' do
      subject.top_up(90)
      amount = 90
    expect { subject.deduct(90) }.to change {subject.balance }.by -amount
    end
  end

end
