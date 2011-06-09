require 'minitest/autorun'
require 'lib/junodoc'

JunoDoc.configure do |config|
  config.class_path << '/Applications/OpenOffice.org.app/Contents/MacOS/'
  config.class_path << '/Applications/OpenOffice.org.app/Contents/basis-link/ure-link/share/java'
  config.class_path << '/Applications/OpenOffice.org.app/Contents/basis-link/program/classes'
end
