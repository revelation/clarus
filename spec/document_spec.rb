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
    it "should be an instance of Clarus::Document" do
      @clarus.class.must_equal(Clarus::Document)
    end

    it "should be able to add text to the document" do
      @clarus.add_text("istanbul, not constantinople")
      @clarus.stream_document.must_equal File.read(Dir.pwd + '/spec/fixtures/add_text.doc').strip
    end

    it "should be able to add a paragraph break" do
      @clarus.add_text("istanbul, not constantinople")
      @clarus.add_paragraph_break
      @clarus.add_text("istanbul, not constantinople")
      @clarus.stream_document.must_equal File.read(Dir.pwd + '/spec/fixtures/add_paragraph_break.doc').strip
    end


    it "should be able to add an image by url" do
      @clarus.add_text("istanbul, not constantinople")
      @clarus.add_paragraph_break
      @clarus.add_image(image_fixture_path)
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_image.doc').strip
    end

    it "should be able to add a heading" do
      @clarus.add_heading("She'll be waiting in istanbul")
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_heading.doc').strip
    end

    it "should be able to add bold text to a paragraph" do
      @clarus.add_text("If you've a date in constantinople", :bold => true)
      @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_bolded_text.doc').strip
    end

    it "should be able to add text to a paragraph that is underlined" do
      @clarus.add_text("istanbul, not constantinople", :underline => true)
      @clarus.stream_document.must_equal File.read(Dir.pwd + '/spec/fixtures/add_underlined_text.doc').strip
    end

    it "should be able to write out the document to disk" do
      @clarus.add_text("istanbul, not constantinople")
      full_file_path = Dir.pwd + '/spec/output/test.doc'
      @clarus.write_document(full_file_path)
      File.exists?(full_file_path).must_equal true
      File.unlink(full_file_path)
    end

    describe '#add_element' do

      it "should add a text element" do
        text_element = {
          'type' => 'text',
          'value' => 'istanbul, not constantinople'
        }
        @clarus.add_element(text_element)
        @clarus.stream_document.must_equal File.read(Dir.pwd + '/spec/fixtures/add_text.doc').strip
      end

      it "should add an image element" do
        image_element = {
          'type' => 'image',
          'value' => image_fixture_path
        }
        @clarus.add_element(image_element)
        @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_image.doc').strip
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
        clarus.stream_document.must_equal File.read(Dir.pwd + '/spec/fixtures/add_text.doc').strip
      end
    end

  end
end
