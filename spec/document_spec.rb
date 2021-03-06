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

      it "should handle indentation" do
        @clarus.new_paragraph(1) do |p|
          p.add_text("Why did constantinople get the works?")
          p.render.must_match File.read(Dir.pwd + '/spec/output/indent.doc').strip
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

    describe "#text" do
      it "should be able to add a text block" do
        @clarus.text("now it's istanbul, not constantinople")
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/output/add_text_document.doc').strip
      end

      it "should support indentation" do
        @clarus.text("This text is indented two levels.", nil, 2)
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/output/double_indent.doc').strip
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
