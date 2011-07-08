require File.dirname(__FILE__) + "/spec_helper"
require 'benchmark'

Benchmark.benchmark do |x|
  x.report("creating 1 docs with 100 images and paragraphs") do
    @clarus = Clarus::Document.new
    100.times do
      @clarus.image("https://www.studyspace.net/system/uploads/0011/7809/ruby.jpg")
    end
    @clarus.write_document('benchmark_test.doc')
  end
end
