module ULS
  module Records
    # This represents the Main Form 605 data that does not carry over to the license.
    class FormSecondary < Base 
      uls_field_accessor :unique_system_identifier, type: :numeric
      uls_field_accessor :uls_file_number
      uls_field_accessor :ebf_number
      uls_field_accessor :application_purpose
      uls_field_accessor :application_status
      uls_field_accessor :application_fee_exempt
      uls_field_accessor :regulatory_fee_exempt
      uls_field_accessor :source
      uls_field_accessor :requested_expiration_date_mmdd
      uls_field_accessor :receipt_date
      uls_field_accessor :notification_code
      uls_field_accessor :notification_date
      uls_field_accessor :expanding_area_or_contour
      uls_field_accessor :change_type
      uls_field_accessor :original_application_purpose
      uls_field_accessor :requesting_a_waiver
      uls_field_accessor :how_many_waivers_requested, type: :numeric
      uls_field_accessor :any_attachments
      uls_field_accessor :number_of_requested_sids, type: :numeric
      uls_field_accessor :fee_control_num
      uls_field_accessor :date_entered
      uls_field_accessor :reason
      uls_field_accessor :frequency_coordination_indicat
      uls_field_accessor :emergency_sta
      uls_field_accessor :overall_change_type
      uls_field_accessor :slow_growth_ind
      uls_field_accessor :previous_waiver
      uls_field_accessor :waiver_deferral_fee
      uls_field_accessor :has_term_pending_ind
    end
  end
end
