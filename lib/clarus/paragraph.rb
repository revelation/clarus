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

    def indent(depth)
    end

    def add_heading(text)
      @style = '<w:pStyle w:val="Heading1" />'
      add_text(text)
    end

    def add_hyperlink(uri, title)
    end

    def add_image(image_url)
    end

    def render
      document_template = File.read(File.expand_path('../templates/paragraph_fragment_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result(:style => @style, :finished_text => @finished_text)
    end
  end
end
