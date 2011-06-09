require 'java'
require 'junodoc/version'
require 'junodoc/configuration'
require 'junodoc/document'

module JunoDoc
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)

      configuration[:class_path].each do |path|
        $CLASSPATH << path
      end
    end
  end
end
