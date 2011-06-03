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
end
