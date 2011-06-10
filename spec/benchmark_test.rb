require File.dirname(__FILE__) + "/spec_helper"
require 'benchmark'

Benchmark.benchmark do |x|
  x.report("creating 1 docs with 500 images and paragraphs") do
    @junodoc = JunoDoc::Document.new
    @junodoc.name = "test.doc"
    500.times do
      @junodoc.add_text("istanbul, not constantinople")
      @junodoc.add_paragraph_break
      @junodoc.add_image("file://#{Dir.pwd}/spec/fixtures/image.jpg")
    end
    @junodoc.write_document(Dir.pwd + '/spec/output/')
  end
end
