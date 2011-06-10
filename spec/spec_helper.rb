require 'minitest/autorun'
require 'lib/junodoc'

JunoDoc.configure do |config|
  config.class_path << 'jars/'
end
