require 'date'

module ULS
  module Records
    # The base class for all ULS records we'll be parsing.  This handles some
    # of the helper methods for defining attributes and actually performing
    # the parsing after the record is defined.
    class Base
      DEFAULT_ATTRIBUTE_OPTIONS = { type: :string }.freeze
      FIELD_SEPARATOR = '|'.freeze
      BLANK_RE = /\A[[:space:]]*\z/ # h/t Rails .blank? implementation

      class << self
        def uls_field_accessor(symbol, options = {})
          field = { attribute: symbol }
          field.merge!(options)
          field = DEFAULT_ATTRIBUTE_OPTIONS.merge(field)

          fields << field

          attr_accessor symbol
        end

        def fields
          @fields ||= []
        end
      end

      def initialize(line = nil)
        return if line.nil?

        from_row(line)
      end

      def from_row(line)
        values = line.split(FIELD_SEPARATOR)
        values.shift


        values.each_with_index do |value, index|
          break if index >= self.class.fields.size

          field = self.class.fields[index]
          setter = "#{field[:attribute]}="
          value = convert(value, field[:type])

          send(setter, value)
        end
      end

      protected

      def convert(value, type)
        begin
          return type.new(value) if type.respond_to?(:ancestors) && type.ancestors.include?(ULS::Codes::Base)
        rescue ArgumentError => e
          return nil
        end

        # The FCC uses blank values to represent certain codes so this check is after
        # any code conversion that may occur.  Beyond the codes, we want to set blanks
        # to nil since that's what they represent normally.
        return nil if blank?(value)

        case type
        when :numeric
          value.to_i
        when :date
          Date.strptime(value, '%m/%d/%Y')
        else
          value
        end
      end

      def blank?(value)
        return true if value.nil? || BLANK_RE.match?(value)
      end
    end
  end
end
