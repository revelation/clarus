class Clarus::TextBlockSpec < MiniTest::Spec
  it "should render to text" do
    text = Clarus::TextBlock.new('Text blox', nil)
    text.render.must_match(File.read(Dir.pwd + '/spec/output/text_block.doc').strip)
  end

  it "should HTML entity escape ampersands" do
    text = Clarus::TextBlock.new('Text & blox', nil)
    text.render.must_match(File.read(Dir.pwd + '/spec/output/text_block_ampersand_escaping.doc').strip)
  end
end
