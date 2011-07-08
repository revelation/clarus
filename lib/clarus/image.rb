require 'open-uri'
require 'base64'
require 'image_size'

module Clarus
  class Image
    def initialize(uri)
      @image_path = uri
      get_image_data
      get_image_dimensions
    end

    def get_image_dimensions
      @image_size = ImageSize.new(get_image_data)
    end

    def get_image_data
      @image_data ||= open(@image_path).read
    end

    def encoded_image
      @image_blob ||= Base64.encode64(get_image_data)
    end

    def render
      document_template = File.read(File.expand_path('../templates/image_template.erb', __FILE__))
      filename = File.basename(@image_path)
      wordml_filename = "wordml://#{Time.now.to_i}#{filename}"
      Erubis::Eruby.new(document_template).result(
        :wordml_filename => wordml_filename,
        :width => @image_size.width,
        :height => @image_size.height,
        :filename => filename,
        :bindata => encoded_image
      )
    end
  end
end
