require File.dirname(__FILE__) + "/spec_helper"

10.times do |n|
  puts "Iteration #{n}"
  puts Time.now
  @junodoc = JunoDoc::Document.new
  1000.times do
    @junodoc.add_text("istanbul, not constantinople")
    @junodoc.add_paragraph_break
    @junodoc.add_image("file://#{Dir.pwd}/spec/fixtures/image.jpg")
  end
  @junodoc.write_document(Dir.pwd + '/spec/output/test.doc')
  @junodoc.close_document
  puts Time.now
end
