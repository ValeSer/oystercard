class Oystercard
  attr_reader :balance, :in_journey

  LIMIT = 90
  ERROR_LIMIT_EXCEEDED = "top up limit of #{LIMIT} reached"


  def initialize
    @balance =  0
    @in_journey = false
  end

  def top_up(amount)

    raise ERROR_LIMIT_EXCEEDED if (@balance + amount) > 90

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey
  end


end
