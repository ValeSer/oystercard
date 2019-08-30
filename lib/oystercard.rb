require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :journeys, :journey

  LIMIT = 90
  ERROR_LIMIT_EXCEEDED = "top up limit of #{LIMIT} reached"
  ERROR_MINIMUM_BALANCE = 'Insufficient balance to touch in'
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize(journey_class = Journey)
    @balance =  0
    @journeys = []
    @journey = journey_class.new
  end

  def top_up(amount)
    raise ERROR_LIMIT_EXCEEDED if (@balance + amount) > LIMIT
    @balance += amount
  end

  def in_journey?
    !!@journey.entry_station
  end

  def touch_in(station)
    deduct(@journey.fare)
    check_error

    raise ERROR_MINIMUM_BALANCE if @balance < MINIMUM_BALANCE

    @journey.set_entry(station)
  end

  def touch_out(exit_station)
    @journey.set_exit(exit_station)
    deduct(@journey.fare)
    next_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def check_error
    next_journey() if !@journey.complete?
  end

  def next_journey
    @journeys << @journey
    @journey = Journey.new
  end

end
