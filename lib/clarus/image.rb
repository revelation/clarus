require 'open-uri'
require 'base64'

module Clarus
  class Image
    def initialize(uri)
      @image_path = uri
    end

    def image_blob
      Base64.encode64(open(@image_path).read)
    end

    def render
      document_template = File.read(File.expand_path('../templates/image_template.erb', __FILE__))
      filename = File.basename(@image_path)
      wordml_filename = "wordml://#{Time.now.to_i}#{filename}"
      Erubis::Eruby.new(document_template).result(
        :wordml_filename => wordml_filename,
        :width => 600,
        :height => 400,
        :filename => filename,
        :bindata => image_blob
      )
    end
  end
end
