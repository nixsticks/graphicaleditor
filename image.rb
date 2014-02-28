require 'matrix'

class Image
  attr_reader :x, :y
  attr_accessor :pixels

  NEIGHBORS = [[0,-1], [0,1], [-1,0], [1,0], [-1,-1], [1,-1], [-1,1], [1,1]]

  def initialize(x, y)
    @x = x
    @y = y
    self.c
  end

  def [](x, y)
    pixels[x-1, y-1]
  end

  def []=(x, y, value)
    pixels[x-1, y-1] = value
  end

  def c
    @pixels = Matrix.build(x,y) { "O" }
  end

  def l(x, y, color)
    self[x, y] = color if exists?(x, y)
  end

  def h(x, y1, y2, color)
    for i in (y1..y2) do
      self[x, i] = color if exists?(x, i)
    end
  end

  def v(y, x1, x2, color)
    for i in (x1..x2) do 
      self[i, y] = color if exists?(i, y)
    end
  end

  def f(x, y, final_color)
    flood(x, y, self[x,y], final_color) if exists?(x, y)
  end

  def flood(x, y, initial_color, final_color)
    return if self[x, y] != initial_color || self[x, y] == final_color

    l(x, y, final_color)

    collect_neighbors(x, y).each do |location|
      self.flood(location[0],location[1], initial_color, final_color)
    end
  end

  def collect_neighbors(x, y)
    NEIGHBORS.map do |n|
      n_x = x + n[0]
      n_y = y + n[1]

      [n_x, n_y] if exists?(n_x, n_y)
    end.compact
  end

  def exists?(x, y)
    x >= 1 && y >= 1 && x <= @x && y <= @y
  end

  def s
    puts
    pixels.to_a.each do |row|
      row.each {|pixel| print pixel + " "}
      puts
    end
    puts
  end
end