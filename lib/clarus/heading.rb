module Clarus
  class Heading
    def initialize
      @style = '<w:pStyle w:val="Heading1" />'
      @finished_text = ""
    end

    def add_text(text)
      @finished_text.concat "<w:t>#{text}</w:t>\n"
    end

    def render
      document_template = File.read(File.expand_path('../templates/paragraph_fragment_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result(:style => @style, :finished_text => @finished_text)
    end
  end
end

