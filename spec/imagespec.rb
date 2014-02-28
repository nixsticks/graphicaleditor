require_relative '../image'
require_relative '../matrix'

describe Image do
  let(:image) { Image.new(5,6) }

  describe '#initialize' do
    it 'should create an image with the correct dimensions' do
      expect(image.x).to eq(5)
      expect(image.y).to eq(6)
    end

    it 'should populate the image with white pixels' do
      expect(image[2,3]).to eq("O")
    end
  end

  describe '#clear' do
    it 'should set all pixels to white' do
      image.fill(1, 1, "R")
      image.clear

      expect(image[2,3]).to eq("O")
    end
  end

  describe '#color' do
    it 'should change the color of the selected pixel' do
      image.color(1, 1, "O")

      expect(image[1,1]).to eq("O")
    end
  end

  describe '#horizontal' do
    it 'should draw a horizontal segment of a certain color in row Y between columns X1 and X2' do
      image.horizontal(2, 3, 5, "R")

      expect(image[2, 4]).to eq("R")
      expect(image[2, 6]).to eq("O")
    end
  end

  describe '#vertical' do
    it 'should draw a vertical segment of a certain color in column X between rows Y1 and Y2' do
      image.vertical(2, 2, 4, "R")

      expect(image[2, 2]).to eq("R")
      expect(image[5, 2]).to eq("O")
    end
  end

  describe '#fill' do
    it 'should fill the region R with the color C' do
      image.color(1, 1, "R")
      image.color(2, 1, "R")

      image.fill(3, 1, "B")

      expect(image[1, 1]).to eq("R")
      expect(image[3, 5]).to eq("B")
      expect(image[4, 5]).to eq("B")
      expect(image[5, 5]).to eq("B")
    end
  end
end