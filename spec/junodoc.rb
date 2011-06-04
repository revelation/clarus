require 'minitest/autorun'
require 'lib/junodoc.rb'

describe JunoDoc::Document do
  before do
    @junodoc = JunoDoc::Document.new
  end

  it "should be an instance of JunoDoc::Document" do
    @junodoc.class.must_equal(JunoDoc::Document)
  end

  it "should be able to set the name of the document" do
    @junodoc.name = "what's_up.doc"
    @junodoc.name.must_equal("what's_up.doc")
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
    @junodoc.add_image('http://whoahbot.com/images/octocat.png')
  end
end
