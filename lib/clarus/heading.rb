module Clarus
  class Heading
    def initialize
      @text = ""
    end

    def add_text(text)
      @text.concat text
    end

    def render
      document_template = File.read(File.expand_path('../templates/header_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result(:text => @text)
    end
  end
end

