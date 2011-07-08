require File.dirname(__FILE__) + "/spec_helper"

class Clarus::ImageSpec < MiniTest::Spec
  describe Clarus::Image do
    before do
      @image = Clarus::Image.new("https://encrypted.google.com/images/logos/ssl_ps_logo.png")
    end

    it "should calculate the size of the image" do
      @image.get_image_dimensions.height.must_equal 126
      @image.get_image_dimensions.width.must_equal 364
    end

    it "should return the image base64 encoded" do
      @image.encoded_image.must_match File.read(File.expand_path('../output/encoded_image.txt', __FILE__)).strip
    end
  end
end
