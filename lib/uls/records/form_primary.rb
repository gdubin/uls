module ULS
  module Records
    # This represents the main form 605 data that carries over to the license.
    class FormPrimary < Base 
      uls_field_accessor :unique_system_identifier, type: :numeric
      uls_field_accessor :uls_file_number
      uls_field_accessor :ebf_number
      uls_field_accessor :call_sign
      uls_field_accessor :license_status, type: ULS::Codes::LicenseStatus
      uls_field_accessor :radio_service_code
      uls_field_accessor :grant_date, type: :date
      uls_field_accessor :expired_date, type: :date
      uls_field_accessor :cancellation_date, type: :date
      uls_field_accessor :eligibility_rule_num
      uls_field_accessor :applicant_type_code_reserved
      uls_field_accessor :alien
      uls_field_accessor :alien_government
      uls_field_accessor :alien_corporation
      uls_field_accessor :alien_officer
      uls_field_accessor :alien_control
      uls_field_accessor :revoked
      uls_field_accessor :convicted
      uls_field_accessor :adjudged
      uls_field_accessor :involved_reserved
      uls_field_accessor :common_carrier
      uls_field_accessor :non_common_carrier
      uls_field_accessor :private_comm
      uls_field_accessor :fixed
      uls_field_accessor :mobile
      uls_field_accessor :radiolocation
      uls_field_accessor :satellite
      uls_field_accessor :developmental_or_sta
      uls_field_accessor :interconnected_service
      uls_field_accessor :certifier_first_name
      uls_field_accessor :certifier_mi
      uls_field_accessor :certifier_last_name
      uls_field_accessor :certifier_suffix
      uls_field_accessor :certifier_title
      uls_field_accessor :gender
      uls_field_accessor :african_american
      uls_field_accessor :native_american
      uls_field_accessor :hawaiian
      uls_field_accessor :asian
      uls_field_accessor :white
      uls_field_accessor :ethnicity
      uls_field_accessor :effective_date
      uls_field_accessor :last_action_date
      uls_field_accessor :auction_id, type: :numeric
      uls_field_accessor :reg_stat_broad_serv
      uls_field_accessor :band_manager
      uls_field_accessor :type_serv_broad_serv
      uls_field_accessor :alien_ruling
      uls_field_accessor :licensee_name_change
    end
  end
end
