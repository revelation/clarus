require 'minitest/autorun'
require 'lib/junodoc'

describe JunoDoc::Document do
  before do
    @junodoc = JunoDoc::Document.new
  end

  it "should be an instance of JunoDoc::Document" do
    @junodoc.class.must_equal(JunoDoc::Document)
    @junodoc.close_document
  end

  it "should be able to set the name of the document" do
    @junodoc.name = "what's_up.doc"
    @junodoc.name.must_equal("what's_up.doc")
    @junodoc.close_document
  end

  it "should be able to add text to the document" do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.close_document
  end

  it "should be able to add a paragraph break" do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.add_paragraph_break
    @junodoc.close_document
  end

  it "should be able to add an image by url" do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.add_paragraph_break
    @junodoc.add_image("file://#{Dir.pwd}spec/fixtures/image.jpg")
    @junodoc.close_document
  end

  it "should be able to write out the document to disk" do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.add_paragraph_break
    @junodoc.add_image("file://#{Dir.pwd}/spec/fixtures/image.jpg")
    @junodoc.write_document(Dir.pwd + '/spec/output/test.doc')
    @junodoc.close_document
  end
end
