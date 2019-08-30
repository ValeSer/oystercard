require 'journey'

describe Journey do
  let(:journey) { Journey.new('entry', 'exit', 0)}

  context ' initialize' do
    it 'has a entry_station' do
      expect(journey.entry_station).to eq 'entry'
    end

    it 'has a exit_station' do
      expect(journey.exit_station).to eq 'exit'
    end

    it 'has the zone calculator' do
      expect(journey.zone_diff).to eq 0
    end

  end





end
