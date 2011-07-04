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
        finished_text.concat "<w:b/>\n"
      elsif style == :underline
        finished_text.concat "<w:u/>\n"
      elsif style == :italic
        finished_text.concat "<w:i/>\n"
      end
      finished_text.concat "<w:t>#{text}</w:t>\n"
    end

    def add_heading(text)
      @style = '<w:pStyle w:val="Heading1" />'
      add_text(text)
    end

    def add_hyperlink(uri, title)
    end

    def add_image(image_url)
    end

    def add_paragraph_break
      "<w:p/>"
    end

    def write_document(path)
      yield(self)
      File.open(path, "w") do |f|
        @doc.result(binding.self) do
          f.write(result)
        end
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
