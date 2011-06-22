require File.expand_path('../../../jars/j2w-ejb-2.0_2011Jun06', __FILE__)
require File.expand_path('../../../jars/xstream-1.3.1', __FILE__)
require 'json'

module Clarus

  class Document
    java_import 'java.io.PrintWriter'
    java_import 'java.io.File'
    java_import 'word.api.interfaces.IDocument'
    java_import 'word.w2004.Document2004'
    java_import 'word.w2004.elements.BreakLine'
    java_import 'word.w2004.elements.Heading1'
    java_import 'word.w2004.elements.Image'
    java_import 'word.w2004.elements.ImageLocation'
    java_import 'word.w2004.elements.Paragraph'
    java_import 'word.w2004.elements.ParagraphPiece'
    java_import 'word.w2004.elements.Table'

    ELEMENT_TYPES = [
      'text',
      'image',
      'paragraph_break'
    ]

    def self.load_json json_str
      doc = Document.new
      elements = JSON.parse json_str
      elements.each do |el|
        doc.add_element el
      end
      doc
    end

    def initialize
      @doc = create_document
    end

    def add_element elem_hash
      type = elem_hash['type']
      val  = elem_hash['value']
      add_method = "add_#{type}"
      send(add_method, val)
    end

    def add_text(text, style = nil)
      if style
        if style[:bold]
          paragraph_piece = Java::word::w2004::elements::ParagraphPiece.new(text)
          paragraph_piece.withStyle.bold
          @doc.getBody.addEle(Paragraph.withPieces(paragraph_piece))
        elsif style[:underline]
          paragraph_piece = Java::word::w2004::elements::ParagraphPiece.new(text)
          paragraph_piece.withStyle.underline
          @doc.getBody.addEle(Paragraph.withPieces(paragraph_piece))
        end
      else
        @doc.getBody.addEle(Paragraph.new(text))
      end
    end

    def add_heading(text)
      @doc.getBody.addEle(Heading1.new(text))
    end

    def add_image(image_url)
      image = Image.from_WEB_URL(image_url)
      @doc.getBody.addEle(image)
      image = nil
    end

    def add_paragraph_break
      @doc.getBody.addEle(BreakLine.new)
    end

    def write_document(path)
      writer = PrintWriter.new(File.new(path))
      writer.println(@doc.getContent)
      writer.close
      @doc = nil
    end

    def stream_document
      @doc.getContent
    end

    private
    def create_document
      @doc = Document2004.new
    end
  end
end
