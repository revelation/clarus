module Clarus
  class Document
    def initialize
      @doc = create_document
      @items = []
    end

    def text(val, text_style = nil, indent = 0)
      new_paragraph(indent) do |p|
        p.add_text(val, text_style)
      end
    end

    def new_paragraph(indent = 0)
      paragraph = Clarus::Paragraph.new(indent)
      yield(paragraph)
      @items << paragraph
    end

    def new_heading
      heading = Clarus::Heading.new
      yield(heading)
      @items << heading
    end

    def link(destination, text)
      @items << Clarus::Link.new(destination, text)
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
      @items << Clarus::ParagraphBreak.new
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
