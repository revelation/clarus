module Clarus
  class Link
    def initialize(destination, text = nil)
      @destination = destination
      @text = text || destination
    end

    def render
      document_template = File.read(File.expand_path('../templates/link_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result(:text => @text, :destination => @destination)
    end
  end
end
