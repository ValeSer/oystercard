require 'station'

describe Station do
  let(:station) { Station.new('name', 1) }

  context 'initialize' do
    it 'has a name' do
      expect(station.name).to eq 'name'
    end

    it 'has a zone' do
      expect(station.zone).to eq 1
    end
  end



end
