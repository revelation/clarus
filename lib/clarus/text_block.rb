require 'cgi'

module Clarus
  class TextBlock
    def initialize(text, text_style)
      text = escape_text(text)
      @text = text
      if text_style == :bold
        @style = '<w:b/>\n'
      elsif text_style == :underline
        @style = '<w:u w:val="single"/>\n'
      elsif text_style == :italic
        @style = '<w:i/>\n'
      end
    end

    def escape_text(text)
      CGI.escapeHTML text
    end

    def render
      document_template = File.read(File.expand_path('../templates/text_block_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result(:style => @style,
                                                  :text => @text)
    end
  end
end
