module Clarus
  class Paragraph
    def initialize
      @style = nil
      @finished_text = ""
    end

    def add_text(text, text_style = nil)
      if text_style == :bold
        @finished_text.concat "<w:b/>\n"
      elsif text_style == :underline
        @finished_text.concat "<w:u/>\n"
      elsif text_style == :italic
        @finished_text.concat "<w:i/>\n"
      end
      @finished_text.concat "<w:t>#{text}</w:t>\n"
    end

    def finished_paragraph(indent = nil)
      document_template = File.read(File.expand_path('../templates/paragraph_fragment_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result(:style => @style, :finished_text => @finished_text)
    end
  end
end
