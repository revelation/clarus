module Clarus
  class Document
    attr_accessor :items

    def initialize
      @doc = create_document
      @items = []
    end

    def new_paragraph
      new_paragraph = Clarus::Paragraph.new
      yield(new_paragraph)
      @items << new_paragraph
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

    def stream_document
      @doc.result(binding)
    end

    private
    def create_document
      document_template = File.read(File.expand_path('../templates/document_template.erb', __FILE__))
      Erubis::Eruby.new(document_template)
    end
  end
end
