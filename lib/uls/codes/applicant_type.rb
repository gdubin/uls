module ULS
  module Codes
    class ApplicantType < Base
      define_uls_code 'B', description: 'Amateur Club'
      define_uls_code 'C', description: 'Corporation'
      define_uls_code 'D', description: 'General Partnership'
      define_uls_code 'E', description: 'Limited Partnership'
      define_uls_code 'F', description: 'Limited Liability Partnership'
      define_uls_code 'G', description: 'Government Entity'
      define_uls_code 'H', description: 'Other'
      define_uls_code 'I', description: 'Individual'
      define_uls_code 'J', description: 'Joint Venture'
      define_uls_code 'L', description: 'Limited Liability Company'
      define_uls_code 'M', description: 'Military Recreation'
      define_uls_code 'O', description: 'Consortium'
      define_uls_code 'P', description: 'Partnership'
      define_uls_code 'R', description: 'RACES'
      define_uls_code 'T', description: 'Trust'
      define_uls_code 'U', description: 'Unincorporated Association'
    end
  end
end
