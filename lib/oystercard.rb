class Oystercard
  attr_reader :balance, :in_journey, :entry_station

  LIMIT = 90
  ERROR_LIMIT_EXCEEDED = "top up limit of #{LIMIT} reached"
  ERROR_MINIMUM_BALANCE = 'Insufficient balance to touch in'
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize
    @balance =  0
    @entry_station = nil
  end

  def top_up(amount)
    raise ERROR_LIMIT_EXCEEDED if (@balance + amount) > LIMIT
    @balance += amount
  end

  def in_journey?
    @entry_station
  end

  def touch_in(entry_station)
    raise ERROR_MINIMUM_BALANCE if @balance < MINIMUM_BALANCE
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
     @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
