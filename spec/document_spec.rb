require File.dirname(__FILE__) + "/spec_helper"

describe JunoDoc::Document do
  before do
    @junodoc = JunoDoc::Document.new
  end

  it "should be an instance of JunoDoc::Document" do
    @junodoc.class.must_equal(JunoDoc::Document)
  end

  it "should be able to add text to the document" do
    @junodoc.add_text("istanbul, not constantinople")
  end

  it "should be able to add a paragraph break" do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.add_paragraph_break
  end

  it "should be able to add an image by url" do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.add_paragraph_break
    @junodoc.add_image("file://#{Dir.pwd}/spec/fixtures/image.jpg")
  end

  it "should be able to write out the document to disk" do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.add_paragraph_break
    @junodoc.add_image("file://#{Dir.pwd}/spec/fixtures/image.jpg")
    full_file_path = Dir.pwd + '/spec/output/test.doc'
    @junodoc.write_document(full_file_path)
    File.exists?(full_file_path).must_equal true
    File.unlink(full_file_path)
  end
end
