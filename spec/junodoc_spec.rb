require File.dirname(__FILE__) + "/spec_helper"

describe JunoDoc do
  describe "#configure" do
    it "should yield a configuration object" do
      JunoDoc.configure do |config|
        config.class.must_equal(JunoDoc::Configuration)
      end
    end

    it "should yield to a block to set up it's configuration" do
      JunoDoc.configure do |config|
        config.class_path << '/duh/buh/fuh'
      end

      JunoDoc.configuration[:class_path].must_include '/duh/buh/fuh'
    end
  end
end
