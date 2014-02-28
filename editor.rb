class Editor
  attr_accessor :image

  def welcome
    puts "Welcome to the image editor!"
  end

  def command(line)
    case line
    when /^i (\d+) (\d+)$/
      @image = Image.new($1.to_i, $2.to_i)
    when /^([cs])$/
      $1 == "c" ? image.clear : draw
    when /^([lf]) (\d+) (\d+) ([a-z])$/
      $1 == "l" ? image.color($2.to_i, $3.to_i, $4.upcase) : image.fill($2.to_i, $3.to_i, $4.upcase)
    when /^([vh]) (\d+) (\d+) (\d+) ([a-z])$/
       $1 == "v" ? image.vertical($2.to_i, $3.to_i, $4.to_i, $5.upcase) : image.horizontal($2.to_i, $3.to_i, $4.to_i, $5.upcase)
    when /^x$/
      exit
    else
      puts "Sorry, I didn't understand your input."
      command(Editor.input)
    end
  end

  def draw
    image.pixels.to_a.each do |row|
      row.each {|pixel| print pixel + " "}
      puts
    end
  end

  def self.input
    gets.chomp.downcase
  end

  def self.run
    editor = self.new

    editor.welcome
    loop { editor.command(input) }
  end
end