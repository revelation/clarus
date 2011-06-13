require 'java'
require 'clarus/version'
require 'clarus/configuration'
require 'clarus/document'

module Clarus
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
