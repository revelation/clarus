require File.dirname(__FILE__) + "/spec_helper"

describe JunoDoc::Document do
  before do
    @config = JunoDoc::Configuration.new
  end

  it "should store the class path" do
    @config.class_path << '/Applications/OpenOffice.org.app/Contents/MacOS/'
  end

  it "should be able to read configuration variables like a hash" do
    @config.class_path << '/Applications/OpenOffice.org.app/Contents/MacOS/'
    @config[:class_path].must_equal ['/Applications/OpenOffice.org.app/Contents/MacOS/']
  end
end
