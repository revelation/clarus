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
    @junodoc.stream_document.must_equal File.read(Dir.pwd + '/spec/fixtures/add_text.doc').strip
  end

  it "should be able to add a paragraph break" do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.add_paragraph_break
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.write_document(Dir.pwd + '/spec/fixtures/add_paragraph_break.doc')
    @junodoc.stream_document.must_equal File.read(Dir.pwd + '/spec/fixtures/add_paragraph_break.doc').strip
  end

  it "should be able to add an image by url" do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.add_paragraph_break
    @junodoc.add_image("file://#{Dir.pwd}/spec/fixtures/image.jpg")
    @junodoc.stream_document.must_equal File.read(Dir.pwd + '/spec/fixtures/add_image.doc').strip
  end

  it "should be able to write out the document to disk" do
    @junodoc.add_text("istanbul, not constantinople")
    full_file_path = Dir.pwd + '/spec/output/test.doc'
    @junodoc.write_document(full_file_path)
    File.exists?(full_file_path).must_equal true
    File.unlink(full_file_path)
  end
end
