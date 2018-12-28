class Point
  attr_accessor :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end
end

module Command
  def execute
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end
end

class MicroCommand
  include Command

  def initialize
    @commands = []
  end

  def execute
    @commands.each do |command|
      command.execute
    end
  end

  def append(command)
    @commands.push(command)
  end

  def undo
    @commands.pop
  end

  def clear
    @commands.clear
  end

  def count
    @commands.count
  end
end

class DrawCommand
  include Command

  def initialize(drawable, position)
    @drawable = drawable
    @position = position
  end

  def execute
    @drawable.draw(@position.x, @position.y)
  end
end

module Drawable
  def draw(x, y)
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end
end

class DrawCanvas
  include Drawable

  def initialize(width, height, history)
    @history = history
    @width = width
    @height = height
  end

  def repaint
    @history.execute
  end

  def draw(x, y)
    print "draw point >> %3d, %3d : history counts %3d\n" % [x, y , @history.count]
  end
end

class Main
  def initialize
    @history = MicroCommand.new
    @canvas = DrawCanvas.new(400, 400, @history)
  end

  def mouse_dragged(x, y)
    command = DrawCommand.new(@canvas, Point.new(x, y))
    @history.append(command)
    command.execute
  end

  def clear_button
    @history.clear
    @canvas.repaint
  end
end

main = Main.new
100.times do |i|
  print "%3d times: " % (i + 1)
  main.clear_button if (i % 10 + Random.rand(2)).zero?
  main.mouse_dragged(Random.rand(400), Random.rand(400))
end
