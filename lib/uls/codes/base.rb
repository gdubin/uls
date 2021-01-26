module ULS
  module Codes
    # A base class to handle the various codes/descriptions that the ULS database
    # uses throughout their records.
    class Base
      attr_accessor :code

      class << self
        def define_uls_code(code, description:)
          possible_codes[code] = description

          # Takes the description and turns it into a question mark
          # method for quick testing.  For example:
          #
          # 'Active' -> :active?
          # 'Pending Legal Status' -> :pending_legal_status?
          question_method = description.downcase
          question_method.tr!(' ', '_')
          question_method += '?'
          define_method question_method.to_sym do
            self.code.eql?(code)
          end
        end

        def possible_codes
          @possible_codes ||= {}
        end
      end

      def initialize(code = nil)
        return if code.nil?

        raise ArgumentError, "'#{code}' is an invalid code." unless self.class.possible_codes.include?(code)

        self.code = code
      end

      def description
        self.class.possible_codes[code] unless code.nil?
      end
    end
  end
end
