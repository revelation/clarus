require File.dirname(__FILE__) + "/spec_helper"
class Clarus::DocumentSpec < MiniTest::Spec

  def image_fixture_path
    "file://#{Dir.pwd}/spec/fixtures/image.jpg"
  end

  describe Clarus::Document do
    describe "paragraphs" do
      before do
        @clarus = Clarus::Document.new
      end

      it "should allow adding text elements" do
        @clarus.paragraph do |p|
          p.add_text("If you've a date in constantinople")
        end.must_match File.read(Dir.pwd + '/spec/output/paragraph_add_text.doc').strip
      end

      it "should allow a adding multiple elements with different styles to a paragraph" do
        @clarus.paragraph do |p|
          p.add_text("If you've a date in constantinople, ", :bold)
          p.add_text("She'll be waiting in istanbul.", :underline)
        end.must_match File.read(Dir.pwd + '/spec/output/mixed_paragraph_text.doc').strip
      end

      it "should be able to add bold text to a paragraph" do
        @clarus.paragraph do |p|
          p.add_text("If you've a date in constantinople", :bold)
        end.must_match File.read(Dir.pwd + '/spec/output/add_bolded_text.doc').strip
      end

      it "should be able to add text to a paragraph that is underlined" do
        @clarus.paragraph do |p|
          p.add_text("she'll be waiting in istanbul", :underline)
        end.must_match File.read(Dir.pwd + '/spec/output/add_underlined_text.doc').strip
      end

      it "should be able to indent a paragraph" do
        @clarus.paragraph(:indent => 1) do |p|
          p.add_text("istanbul, not constantinople", :underline)
        end

        @clarus.paragraph(:indent => 2) do |p|
          p.add_text("istanbul, not constantinople", :bold)
        end

        @clarus.paragraph(:indent => 3) do |p|
          p.add_text("Why did constantinople get the works?")
        end

        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/output/indent.doc').strip
      end
    end

    it "should be able to add text to the document" do
      @clarus.stream_document do |d|
        d.add_text("istanbul, not constantinople")
      end.stream_document.must_match File.read(Dir.pwd + '/spec/output/add_text.doc').strip
    end

    it "should be able to add a paragraph break" do
      @clarus.stream_document do |doc|
        doc.paragraph do |p|
          p.add_text("istanbul, not constantinople")
        end
        doc.add_paragraph_break
        doc.paragraph do |p|
          p.add_text("istanbul, not constantinople")
        end
      end.must_match File.read(Dir.pwd + '/spec/output/add_paragraph_break.doc').strip
    end

    it "should be able to add an image by url" do
      @clarus.paragraph do |p|
        p.add_text("istanbul, not constantinople")
      end
      @clarus.add_paragraph_break
      @clarus.add_image(image_fixture_path)
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/output/add_image.doc').strip
    end

    it "should be able to add a hyperlink" do
      @clarus.add_hyperlink("http://ffffound.com", "FFFFound!")
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/output/add_hyperlink.doc').strip
    end

    it "should be able to add a heading" do
      @clarus.paragraph do |p|
        p.add_heading("She'll be waiting in istanbul")
      end.must_match File.read(Dir.pwd + '/spec/output/add_heading.doc').strip
    end

    it "should be able to write out the document to disk" do
      @clarus.paragraph do |p|
        p.add_text("istanbul, not constantinople")
      end
      full_file_path = Dir.pwd + '/spec/output/test.doc'
      @clarus.write_document(full_file_path)
      File.exists?(full_file_path).must_equal true
      File.unlink(full_file_path)
    end
  end
end
