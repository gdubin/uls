module ULS
  module Records
    class Entity < Base
      uls_field_accessor :unique_system_identifier, type: :numeric
      uls_field_accessor :file_number
      uls_field_accessor :ebf_number
      uls_field_accessor :call_sign
      uls_field_accessor :entity_type, type: ULS::Codes::EntityType
      uls_field_accessor :licensee_id
      uls_field_accessor :entity_name
      uls_field_accessor :first_name
      uls_field_accessor :middle_name
      uls_field_accessor :last_name
      uls_field_accessor :suffix
      uls_field_accessor :phone
      uls_field_accessor :fax
      uls_field_accessor :email
      uls_field_accessor :street_address
      uls_field_accessor :city
      uls_field_accessor :state
      uls_field_accessor :zipcode
      uls_field_accessor :po_box
      uls_field_accessor :attention_line
      uls_field_accessor :sgin
      uls_field_accessor :frn
      uls_field_accessor :applicant_type, type: ULS::Codes::ApplicantType
      uls_field_accessor :applicant_type_other
      uls_field_accessor :status, type: ULS::Codes::Status
      uls_field_accessor :status_date, type: :date
    end
  end
end
