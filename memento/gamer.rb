require './memento'

class Gamer
  def initialize(money)
    @money = money
    @fruits = ['りんご', 'ぶどう', 'バナナ', 'みかん']
  end

  def money
    @money
  end

  def bet
    dice = Random.rand(6) + 1
    case dice
    when 1
      @money += 100
      puts '所持金が増えました'
    when 2
      @money /= 2
      puts '所持金が半分になりました'
    when 6
      f = fruit
      puts "フルーツ(#{f})をもらいました"
      @fruits << f
    else
      puts '何も起こりませんでした'
    end
  end

  def create_memento
    m = Memento.new(@money)
    @fruits.each {|f|
      m.add_fruit(f) if f =~ /美味しい/
      if f =~ /美味しい/
        p f
      end
    }
    m
  end

  def restore_memento(memento)
    p memento
    @money = memento.money
    @fruits = memento.fruits
  end

  def to_s
    "money = #{money}, fruit #{@fruits}"
  end

  def fruit
    f = ['りんご', 'ぶどう', 'バナナ', 'みかん'].sample
    prefix = (Random.rand(2) == 1 ? '美味しい' : '') + f
  end
end