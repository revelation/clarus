require File.dirname(__FILE__) + "/spec_helper"
require 'json'

class Clarus::DocumentSpec < MiniTest::Spec

  def image_fixture_path
    "file://#{Dir.pwd}/spec/fixtures/image.jpg"
  end

  before do
    @clarus = Clarus::Document.new
  end

  describe Clarus::Document do
    describe "paragraphs" do
      it "should allow a block syntax for adding elements to a paragraph" do
        @clarus.paragraph do |p|
          p.add_text("If you've a date in constantinople", :bold)
          p.add_text("She'll be waiting in istanbul", :underline)
        end
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/mixed_paragraph_text.doc').strip
      end

      it "should be able to add bold text to a paragraph" do
        @clarus.paragraph do |p|
          p.add_text("If you've a date in constantinople", :bold)
        end
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_bolded_text.doc').strip
      end

      it "should be able to add text to a paragraph that is underlined" do
        @clarus.paragraph do |p|
          p.add_text("istanbul, not constantinople", :underline)
        end
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_underlined_text.doc').strip
      end
    end

    it "should be an instance of Clarus::Document" do
      @clarus.class.must_equal(Clarus::Document)
    end

    it "should be able to add text to the document" do
      @clarus.paragraph do |p|
        p.add_text("istanbul, not constantinople")
      end
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_text.doc').strip
    end

    it "should be able to add a paragraph break" do
      @clarus.paragraph do |p|
        p.add_text("istanbul, not constantinople")
      end
      @clarus.add_paragraph_break
      @clarus.paragraph do |p|
        p.add_text("istanbul, not constantinople")
      end
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_paragraph_break.doc').strip
    end

    it "should be able to add an image by url" do
      @clarus.paragraph do |p|
        p.add_text("istanbul, not constantinople")
      end
      @clarus.add_paragraph_break
      @clarus.add_image(image_fixture_path)
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_image.doc').strip
    end

    it "should be able to add a hyperlink" do
      @clarus.add_hyperlink("http://ffffound.com", "FFFFound!")
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_hyperlink.doc').strip
    end

    it "should be able to add a heading" do
      @clarus.add_heading("She'll be waiting in istanbul")
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_heading.doc').strip
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

    describe '#add_element' do
      it "should only allow valid element types" do
        bad_el = {
          'type' => 'EVAL SOME BAD STUFF'
        }
        exp = nil
        begin
          @clarus.add_element(bad_el)
        rescue Exception => exp
        end
        exp.must_be_instance_of(Clarus::DocumentError)
      end

      it "should add a text element" do
        text_element = {
          'type' => 'text',
          'value' => 'istanbul, not constantinople'
        }
        @clarus.add_element(text_element)
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_text.doc').strip
      end

      it "should add an image element" do
        image_element = {
          'type' => 'image',
          'value' => image_fixture_path
        }
        @clarus.add_element(image_element)
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_image.doc').strip
      end

      it "should be able to add a paragraph break element" do
        paragraph_element = {
          'type' => 'paragraph_break'
        }
        @clarus.add_text("istanbul, not constantinople")
        @clarus.add_element(paragraph_element)
        @clarus.add_text("istanbul, not constantinople")
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_paragraph_break.doc').strip
      end

    end

    describe '.load_json' do
      before do
        @text_element = {
          'type' => 'text',
          'value' => 'istanbul, not constantinople'
        }
      end

      it "should be an instance of Clarus::Document" do
        json = JSON.generate [@text_element]
        clarus = Clarus::Document.load_json(json)
        clarus.class.must_equal(Clarus::Document)
      end

      it "should load text content" do
        json = JSON.generate [@text_element]
        clarus = Clarus::Document.load_json(json)
        clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_text.doc').strip
      end
    end

  end
end
