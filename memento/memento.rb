class Memento
  def initialize(money)
    @money = money
    @fruits = []
  end

  def money
    @money
  end

  def add_fruit(fruit)
    @fruits = (@fruits || []) << fruit
  end

  def fruits
    @fruits
  end
end