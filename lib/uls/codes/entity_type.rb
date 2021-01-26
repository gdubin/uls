module ULS
  module Codes
    class EntityType < Base
      define_uls_code 'CE', description: 'Transferee Contact'
      define_uls_code 'CL', description: 'Licensee Contact'
      define_uls_code 'CR', description: 'Assignor or Transferor Contact'
      define_uls_code 'CS', description: 'Lessee Contact'
      define_uls_code 'E', description: 'Transferee'
      define_uls_code 'L', description: 'Licensee or Assignee'
      define_uls_code 'O', description: 'Owner'
      define_uls_code 'R', description: 'Assignor or Transferor'
      define_uls_code 'S', description: 'Lessee'
    end
  end
end
