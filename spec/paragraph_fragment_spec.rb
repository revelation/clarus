require File.dirname(__FILE__) + "/spec_helper"

class Clarus::ParagraphFragmentSpec < MiniTest::Spec
  describe Clarus::ParagraphFragment do
    before do
      @paragraph = Clarus::ParagraphFragment.new
    end

    it "should allow adding text elements" do
      @paragraph.add_text("If you've a date in constantinople", :bold)
    end

    it "should return a finished paragraph made up of paragraph pieces" do
      @paragraph.add_text("If you've a date in constantinople", :bold)
      @paragraph.finished_paragraph.class.must_equal(Paragraph)
    end
  end
end
