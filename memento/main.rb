require './memento'
require './gamer'

class Main
  def self.main
    gamer = Gamer.new(100)
    memento = gamer.create_memento

    100.times{|i|
      puts "=== #{i}"
      puts "現状 #{gamer}"

      gamer.bet
      puts "所持金が#{gamer.money}円になりました"
      if (gamer.money > memento.money)
        puts "だいぶん増えたので現状を保存しておこう"
        memento = gamer.create_memento
      elsif gamer.money < memento.money / 2
        puts "だいぶん減ったので以前の状態に復帰しよう"
        gamer.restore_memento(memento)
      end
    }

    begin
      sleep(1)
    rescue

    end

    puts ""
  end
end

Main.main