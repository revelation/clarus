module JunoDoc
  require File.dirname(__FILE__) + '/../../jars/j2w-ejb-2.0_2011Jun06'
  require File.dirname(__FILE__) + '/../../jars/xstream-1.3.1'

  class Document
    import 'java.io.PrintWriter'
    import 'java.io.File'
    import 'word.api.interfaces.IDocument'
    import 'word.w2004.Document2004'
    import 'word.w2004.elements.BreakLine'
    import 'word.w2004.elements.Heading1'
    import 'word.w2004.elements.Image'
    import 'word.w2004.elements.ImageLocation'
    import 'word.w2004.elements.Paragraph'
    import 'word.w2004.elements.Table'

    def initialize
      @doc = create_document
    end

    def add_text(text)
      @doc.getBody.addEle(Paragraph.new(text))
    end


    def add_image(image_url)
      @doc.getBody.addEle(Image.from_WEB_URL(image_url))
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
