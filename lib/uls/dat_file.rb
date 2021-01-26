module ULS
  # Used to interact with the FCC DAT file.
  class DatFile
    attr_accessor :path

    def initialize(path)
      self.path = path
    end

    def each_line(&_block)
      return unless File.exist?(path)

      File.foreach(path) { |line| yield(line) }
    end

    def each_record(&_block)
      return unless File.exist?(path)

      File.foreach(path) do |line|
        record = line_to_record(line)
        yield(record)
      end
    end

    protected

    def record_class(record_type)
      case record_type
      when 'EN'
        Records::Entity
      when 'HD'
        Records::FormPrimary
      when 'AD'
        Records::FormSecondary
      end
    end

    def line_to_record(line)
      klass = record_class(line[0..1])
      klass.new(line) unless klass.nil?
    end
  end
end
