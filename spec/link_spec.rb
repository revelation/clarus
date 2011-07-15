require File.dirname(__FILE__) + "/spec_helper"

class Clarus::ParagraphSpec < MiniTest::Spec
  before do
    @link = Clarus::Link.new('http://ffffound.com', 'FFFFound!')
  end

  it "should render the link (and I should have better test names :()" do
    @link.render.must_match(File.read(Dir.pwd + '/spec/output/link_test.doc').strip)
  end
end
