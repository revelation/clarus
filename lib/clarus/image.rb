require 'open-uri'

module Clarus
  class Image
    def initialize(uri)
      @image_path = uri
    end

    def image_blob
      open(@image_path).read
    end

    def render
      document_template = File.read(File.expand_path('../templates/image_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result(
        :wordml_filename => nil,
        :width => nil,
        :height => nil,
        :file_name => nil,
        :bindata => nil
      )
    end
  end
end
