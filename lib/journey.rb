class Journey
  attr_accessor :entry_station, :exit_station, :zone_diff

  def initialize(entry = nil, exit = nil, zone_diff = 0)
    @entry_station = entry
    @exit_station = exit
    @zone_diff = zone_diff
  end

  def set_entry(station)
    @entry_station = station
  end

  def set_exit(station)
    @exit_station = station
  end

  def complete?
     (@entry_station && @exit_station) || empty?()
  end

  def empty?
    (!@entry_station && !@exit_station)
  end

  def fare
    return 6 if !complete
    1 unless !empty?()
  end
end
