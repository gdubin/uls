require 'tmpdir'

module ULS
  class Configuration
    attr_accessor :tmpdir

    def initialize
      @tmpdir = Dir.tmpdir
    end
  end
end
