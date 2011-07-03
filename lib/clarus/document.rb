module Clarus
  class DocumentError < StandardError; end

  class Document
    def initialize
      @doc = create_document
    end

    def paragraph
      document_template = File.read(File.expand_path('../templates/paragraph_fragment_template.erb', __FILE__))
      Erubis::Eruby.new(document_template).result({}) do
        yield(self)
      end
    end

    def add_text(text, style = nil)
      finished_text = ""
      if style == :bold
        finished_text << "<w:b/>\n"
      elsif style == :italic
        finished_text << "<w:i/>\n"
      end
      finished_text << "<w:t>#{text}</w:t>"
    end

    def add_heading(text)
    end

    def add_hyperlink(uri, title)
    end

    def add_image(image_url)
    end

    def add_paragraph_break
    end

    def write_document(path)
      result = @doc.result({}) do
        yield(self)
      end
      File.open(path, "w") do |f|
        f.write(result)
      end
    end

    def stream_document
      @doc.result({}) do
        yield(self)
      end
    end

    private
    def create_document
      document_template = File.read(File.expand_path('../templates/document_template.erb', __FILE__))
      Erubis::Eruby.new(document_template)
    end
  end
end
