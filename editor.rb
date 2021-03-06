class Editor
  attr_accessor :image

  def welcome
    puts <<-end
    Welcome to the image editor!

    Commands:
    I M N : Create a new MxN image with all pixels colored white (O).
    C: Clears the table, setting all pixels to white (O).
    L X Y C: Colors the pixel (X,Y) with color C.
    V X Y1 Y2 C: Draw a vertical segment of color C in column X between rows Y1 and Y2 (inclusive).
    H X1 X2 Y C: Draw a horizontal segment of color C in row Y between columns X1 and X2 (inclusive).
    F X Y C: Fill the region R with the color C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same color as (X,Y) and shares a common side with any pixel in R also belongs to this region.
    S: Show the contents of the current image.
    X: Terminate the session.

    end
  end

  def command(line)
    case line
    when /^i (\d+) (\d+)$/
      @image = Image.new($2.to_i, $1.to_i)
    when /^([cs])$/
      image.send($1)
    when /^([lf]) (\d+) (\d+) ([a-z])$/
      image.send($1, $3.to_i, $2.to_i, $4.upcase)
    when /^([vh]) (\d+) (\d+) (\d+) ([a-z])$/
      image.send($1, $2.to_i, $3.to_i, $4.to_i, $5.upcase)
    when /^x$/
      exit
    else
      puts "Sorry, I didn't understand your input."
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