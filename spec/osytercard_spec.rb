require 'oystercard'

describe Oystercard do

  context '#initialize a new card' do
    it { is_expected.to respond_to :top_up }
    it { is_expected.to respond_to :deduct }
    it { is_expected.to respond_to :in_journey? }
    it { is_expected.to respond_to :touch_in }
    it { is_expected.to respond_to :touch_out }

  end

  context '#state of card' do

    it 'is in journey?' do
      expect(subject.in_journey?).to eq false
    end

    it 'touches in' do
      subject.top_up(10)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it 'touches out' do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end

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
