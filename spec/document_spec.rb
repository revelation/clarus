require File.dirname(__FILE__) + "/spec_helper"

describe Clarus::Document do
  before do
    @clarus = Clarus::Document.new
  end

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
    @clarus.add_image("file://#{Dir.pwd}/spec/fixtures/image.jpg")
    @clarus.stream_document.must_match File.read(Dir.pwd + '/spec/fixtures/add_image.doc').strip
  end

  it "should be able to write out the document to disk" do
    @clarus.add_text("istanbul, not constantinople")
    full_file_path = Dir.pwd + '/spec/output/test.doc'
    @clarus.write_document(full_file_path)
    File.exists?(full_file_path).must_equal true
    File.unlink(full_file_path)
  end
end
