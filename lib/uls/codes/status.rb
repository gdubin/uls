module ULS
  module Codes
    class Status < Base
      # Code value is intentionally blank.  That's how the FCC represents
      # an active status: blank or null.
      define_uls_code '', description: 'Active'
      define_uls_code 'X', description: 'Termination Pending' 
      define_uls_code 'T', description: 'Terminated' 
    end
  end
end
