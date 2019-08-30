require 'oystercard'

describe Oystercard do
let(:station) {'entry_station'}
let(:station2) {'exit_station'}
  context 'initialize a new card' do
    it { is_expected.to respond_to :top_up }
    it { is_expected.to respond_to :in_journey? }
    it { is_expected.to respond_to :touch_in }
    it { is_expected.to respond_to :touch_out }
    it { is_expected.to respond_to :journeys }

  end

  context 'state of card' do
    it "has a balance of zero" do
      expect(subject.balance).to eq(0)
    end

    it 'is in journey?' do
      # predicate matcher
      expect(subject).not_to be_in_journey
    end

    it "initiates with an empty journeys history" do
      expect(subject.journeys).to be_empty
    end
  end

  context '#touch_in' do
    before do
      subject.top_up(10)
      subject.touch_in(station)
    end
    it 'touches in' do
      expect(subject).to be_in_journey
    end

    it 'raises an error if balance is less than 1£' do
      card = Oystercard.new
      card.balance
      expect { card.touch_in(station) }.to raise_error Oystercard::ERROR_MINIMUM_BALANCE
    end
  end

  context '#touch_out' do
    before do
      subject.top_up(90)
      subject.touch_in(station)
    end

    it 'deducts money after end the journey' do
      expect { subject.touch_out(station2) }.to change {subject.balance }.by -Oystercard::MINIMUM_CHARGE
    end

    it 'touches out' do
      subject.touch_out(station2)
      expect(subject).not_to be_in_journey
    end

    it 'sets entry_station to nil' do
      subject.touch_out(station2)
      expect(subject.entry_station).to eq nil
    end
  end

  context '#top_up' do

    it 'increases the balance' do
      expect { subject.top_up(1) }.to change {subject.balance }.from(subject.balance).to(subject.balance+1)
    end

    it 'raises error when the top_up is bigger than the limit' do
      expect { subject.top_up(Oystercard::LIMIT + 1) }.to raise_error (Oystercard::ERROR_LIMIT_EXCEEDED)
    end

    it 'raises error when the top_up goes over the limit' do
      subject.top_up(Oystercard::LIMIT - 1)
      expect { subject.top_up(2) }.to raise_error (Oystercard::ERROR_LIMIT_EXCEEDED)
    end
  end

  context "touching in and out" do
    before do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station2)
    end

    it "stores my journey in the journeys array" do
      expect(subject.journeys).not_to be_empty
    end
  end

  end
