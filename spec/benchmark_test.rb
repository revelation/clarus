require File.dirname(__FILE__) + "/spec_helper"
require 'benchmark'

Benchmark.benchmark do |x|
  x.report("creating 1 docs with 500 images and paragraphs") do
    @clarus = Clarus::Document.new
    100.times do
      @clarus.add_text("istanbul, not constantinople")
      @clarus.add_paragraph_break
      @clarus.add_image("file://#{Dir.pwd}/spec/fixtures/image.jpg")
    end
    @clarus.write_document(Dir.pwd + '/spec/output/benchmark_test.doc')
  end
end
