module Clarus
  class Paragraph
    INDENT_CONSTANT = 540

    def initialize(indent = 0)
      @indent = INDENT_CONSTANT * indent
      @style = ""
      @items = []
    end

    def add_text(text, text_style = nil)
      @items << TextBlock.new(text, text_style)
    end

    def render
      document_template = File.read(File.expand_path('../templates/paragraph_fragment_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result(:style => @style,
                                                  :items => @items,
                                                  :indent => @indent)
    end
  end
end
