require File.dirname(__FILE__) + "/spec_helper"

class Clarus::ParagraphSpec < MiniTest::Spec
  describe Clarus::Paragraph do
    before do
      @paragraph = Clarus::Paragraph.new
    end

    it "should allow adding text elements" do
      @paragraph.add_text("If you've a date in constantinople")
      @paragraph.render.must_match File.read(Dir.pwd + '/spec/output/paragraph_add_text.doc').strip
    end

    it "should be able to add bold text to a paragraph" do
      @paragraph.add_text("If you've a date in constantinople", :bold)
      @paragraph.render.must_match File.read(Dir.pwd + '/spec/output/add_bolded_text.doc').strip
    end

    it "should allow a adding multiple elements with different styles to a paragraph" do
      @paragraph.add_text("If you've a date in constantinople, ", :bold)
      @paragraph.add_text("She'll be waiting in istanbul.", :underline)
      @paragraph.render.must_match File.read(Dir.pwd + '/spec/output/mixed_paragraph_text.doc').strip
    end

    it "should be able to add text to a paragraph that is underlined" do
      @paragraph.add_text("she'll be waiting in istanbul", :underline)
      @paragraph.render.must_match File.read(Dir.pwd + '/spec/output/add_underlined_text.doc').strip
    end

    it "should be able to indent a paragraph" do
      @paragraph.indent(1)
      @paragraph.add_text("Why did constantinople get the works?")
      @paragraph.render.must_match File.read(Dir.pwd + '/spec/output/indent.doc').strip
    end

    it "should be able to add an image by url" do
      @paragraph.add_image(image_fixture_path)
      @paragraph.render.must_match File.read(Dir.pwd + '/spec/output/add_image.doc').strip
    end

    it "should be able to add a hyperlink" do
      @paragraph.add_hyperlink("http://ffffound.com", "FFFFound!")
      @paragraph.render.must_match File.read(Dir.pwd + '/spec/output/add_hyperlink.doc').strip
    end

    it "should be able to add a heading" do
      @paragraph.add_heading("She'll be waiting in istanbul")
      @paragraph.render.must_match File.read(Dir.pwd + '/spec/output/add_heading.doc').strip
    end
  end
end
