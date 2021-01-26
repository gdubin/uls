module ULS
  module Codes
    class LicenseStatus < Base
      define_uls_code 'A', description: 'Active'
      define_uls_code 'C', description: 'Canceled'
      define_uls_code 'E', description: 'Expired'
      define_uls_code 'L', description: 'Pending Legal Status'
      define_uls_code 'P', description: 'Parent Station Canceled'
      define_uls_code 'T', description: 'Terminated'
      define_uls_code 'X', description: 'Term Pending'
    end
  end
end
