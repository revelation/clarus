# encoding: UTF-8

require File.dirname(__FILE__) + "/spec_helper"

clarus = Clarus::Document.new

clarus.image("https://github.com/revelation/clarus/raw/master/spec/fixtures/ruby_image.jpg")

clarus.paragraph_break

clarus.new_heading do |h|
  h.add_text("1. Opening This Book")
end

clarus.paragraph_break
clarus.new_paragraph do |p|
  p.add_text("Pretend that you’ve opened this book (although you probably have opened this book), just to find a huge onion right in the middle crease of the book. (The manufacturer of the book has included the onion at my request.)")
end
clarus.paragraph_break

clarus.new_paragraph do |p|
  p.add_text("I’ll be straight with you. I want you to cry. To weep. To whimper sweetly. This book is a ")
  p.add_text(" poignant ", :bold)
  p.add_text("guide to Ruby.")
end

clarus.write_document("output_test.doc")
