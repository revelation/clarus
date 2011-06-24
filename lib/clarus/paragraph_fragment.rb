java_import 'word.w2004.elements.Paragraph'
java_import 'word.w2004.elements.ParagraphPiece'

module Clarus
  class ParagraphFragment
    def initialize
      @paragraph_pieces = []
    end

    def add_text(text, style = nil)
      paragraph_piece = ParagraphPiece.new(text)
      if style
        paragraph_piece.withStyle.send(style)
      end
      @paragraph_pieces << paragraph_piece
    end

    def finished_paragraph
      Paragraph.withPieces(*@paragraph_pieces)
    end

    def dump_content
    end
  end
end
