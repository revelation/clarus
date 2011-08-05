class Clarus::TextBlockSpec < MiniTest::Spec
  it "should render to text" do
    text = Clarus::TextBlock.new('Text blox', nil)
    text.render.must_match(File.read(Dir.pwd + '/spec/output/text_block.doc').strip)
  end

  it "should escape HTML entities" do
    text = Clarus::TextBlock.new('Text & blox and <span>tags</span>', nil)
    text.render.must_match(File.read(Dir.pwd + '/spec/output/text_block_html_escaping.doc').strip)
  end
end
