require File.dirname(__FILE__) + "/spec_helper"

class Clarus::ImageSpec < MiniTest::Spec
  describe Clarus::Image do
    before do
      @image = Clarus::Image.new(File.expand_path('../fixtures/image.jpg', __FILE__))
    end

    it "should return the image base64 encoded" do
      @image.image_blob.must_match File.read(File.expand_path('../output/add_image.doc', __FILE__)).strip
    end
  end
end
