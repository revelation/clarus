module Clarus
  class Paragraph
    INDENT_CONSTANT = 540

    def initialize
      @indent = 0
      @style = ""
      @finished_text = ""
    end

    def add_text(text, text_style = nil)
      if text_style == :bold
        @style = "<w:b/>\n"
      elsif text_style == :underline
        @style = "<w:u/>\n"
      elsif text_style == :italic
        @style = "<w:i/>\n"
      end
      @finished_text.concat text
    end

    def indent(depth)
      @indent = INDENT_CONSTANT * depth
    end

    def render
      document_template = File.read(File.expand_path('../templates/paragraph_fragment_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result(:style => @style,
                                                  :finished_text => @finished_text,
                                                  :indent => @indent)
    end
  end
end
