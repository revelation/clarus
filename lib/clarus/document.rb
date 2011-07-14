module Clarus
  class Document
    def initialize
      @doc = create_document
      @items = []
    end

    def new_paragraph(indent = nil)
      paragraph = Clarus::Paragraph.new(indent)
      yield(paragraph)
      @items << paragraph
    end

    def new_heading
      heading = Clarus::Heading.new
      yield(heading)
      @items << heading
    end

    def write_document(path)
      File.open(path, "w") do |f|
        result = stream_document
        f.write(result)
      end
    end

    def paragraph_break
      @items << Clarus::ParagraphBreak.new
    end

    def image(uri)
      @items << Clarus::Image.new(uri)
    end

    def stream_document
      @doc.result(:items => @items)
    end

    private
    def create_document
      document_template = File.read(File.expand_path('../templates/document_template.erb', __FILE__))
      Erubis::Eruby.new(document_template)
    end
  end
end
