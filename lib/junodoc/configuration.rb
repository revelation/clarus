module JunoDoc
  class Configuration
    attr_accessor :class_path

    def initialize
      @class_path = []
    end

    def [](option)
      send(option)
    end
  end
end
