require File.dirname(__FILE__) + "/spec_helper"

class Clarus::LinkSpec < MiniTest::Spec
  before do
    @link = Clarus::Link.new('http://ffffound.com', 'FFFFound!')
  end

  it "should render the link (and I should have better test names :()" do
    @link.render.must_match(File.read(Dir.pwd + '/spec/output/link_test.doc').strip)
  end

  it "should escape ampersands with &amp; so that word 2003 xml format will parse it without failing" do
    invalid_xml_url = "https://example.com/somepath?var1=swoobaz&var2=swoobinja"
    link = Clarus::Link.new(invalid_xml_url, 'Swoobaz and Swoobinja')
    link.render.must_match(File.read(Dir.pwd + '/spec/output/link_ampersand_escaping.doc').strip)
  end
end
