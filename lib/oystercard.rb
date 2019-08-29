class Oystercard
  attr_reader :balance
  LIMIT = 90
ERROR_LIMIT_EXCEEDED = "top up limit of #{LIMIT} reached"
  def initialize
    @balance =  0
  end

  def top_up(amount)

    raise ERROR_LIMIT_EXCEEDED if (@balance + amount) > 90

    @balance += amount
  end

def deduct(amount)
  @balance -= amount
end


end
