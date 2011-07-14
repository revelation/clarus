require File.dirname(__FILE__) + "/spec_helper"

class Clarus::DocumentSpec < MiniTest::Spec
  describe Clarus::Document do
    before do
      @clarus = Clarus::Document.new
    end

    describe "#new_paragraph" do
      it "should yield a new instance of a Clarus::Paragraph" do
        @clarus.new_paragraph do |p|
          p.class.must_equal(Clarus::Paragraph)
        end
      end
    end

    describe "#paragraph_break" do
      it "should be able to add a paragraph break" do
        @clarus.new_paragraph do |p|
          p.add_text("istanbul, not constantinople")
        end
        @clarus.paragraph_break
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/output/add_paragraph_break.doc').strip
      end
    end

    describe "#image" do
      it "should add an image to the document" do
        @clarus.image("https://encrypted.google.com/images/logos/ssl_ps_logo.png")
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/output/add_image.doc').strip
      end
    end

    describe "#link" do
      it "should be able to add a link to the document" do
        @clarus.link("http://ffffound.com", "FFFFound!")
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/output/add_link.doc').strip
      end
    end

    describe 'writing to file or stdout' do
      it "should stream out the document as text" do
        @clarus.new_paragraph do |p|
          p.add_text("now it's istanbul, not constantinople")
        end
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/output/add_text_document.doc').strip
      end

      it "should be able to write out the document to disk" do
        @clarus.new_paragraph do |p|
          p.add_text("istanbul, not constantinople")
        end
        full_file_path = Dir.pwd + '/spec/output/test.doc'
        @clarus.write_document(full_file_path)
        File.exists?(full_file_path).must_equal true
        File.unlink(full_file_path)
      end
    end
  end
end
