require 'pry'
require 'uls/version'
require 'uls/configuration'
require 'uls/database'
require 'uls/dat_file'
require 'uls/retriever'
require 'uls/codes/base'
require 'uls/codes/status'
require 'uls/codes/license_status'
require 'uls/codes/applicant_type'
require 'uls/codes/entity_type'
require 'uls/records/base'
require 'uls/records/form_primary'
require 'uls/records/form_secondary'
require 'uls/records/entity'

# This gem is for parsing the FCC ULS database files available from the FCC website.
# For additional details, visit http://github.com/gdubin/uls
module ULS
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure(&_block)
    yield(configuration)
  end
end
