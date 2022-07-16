require 'date'
require 'open-uri'
require 'net/http'

module ULS
  class Retriever
    APPLICATION_PREFIX = 'a'.freeze
    LICENSE_PREFIX = 'l'.freeze

    SERVICES = {
      amateur_radio: {
        filename: {
          daily: 'am',
          weekly: 'amat'
        },
        records: {
          applications: APPLICATION_PREFIX,
          licenses: LICENSE_PREFIX
        }
      }
    }.freeze

    # Different base URLs whether we're looking for the daily updates or the full
    # weekly downloads.
    DAILY_BASE_URL = 'https://data.fcc.gov/download/pub/uls/daily'.freeze
    WEEKLY_BASE_URL = 'https://data.fcc.gov/download/pub/uls/complete'.freeze
    
    attr_accessor :service

    def self.amateur_radio
      Retriever.new(:amateur_radio)
    end

    def initialize(service)
      raise ArgumentError, "Invalid service #{service}" unless services.include?(service)

      self.service = service
    end

    def weekly_url(type)
      raise ArgumentError, "Invalid type #{type}" unless types.include?(type)

      prefix = SERVICES[service][:records][type]
      name = SERVICES[service][:filename][:weekly]

      "#{WEEKLY_BASE_URL}/#{prefix}_#{name}.zip"
    end

    def weekly(type)
      url = weekly_url(type)
      download(url)
    end

    def daily_url(type, wday = Date.new.prev_day.wday)
      raise ArgumentError, "Invalid type #{type}" unless types.include?(type)

      abbreviated_day = Date::ABBR_DAYNAMES[wday].downcase
      prefix = SERVICES[service][:records][type]
      name = SERVICES[service][:filename][:daily]

      "#{DAILY_BASE_URL}/#{prefix}_#{name}_#{abbreviated_day}.zip"
    end

    def daily(type, wday = Date.new.prev_day.wday)
      url = daily_url(type, wday)
      download(url)
    end

    def types
      SERVICES[service][:records].keys
    end

    def services
      SERVICES.keys
    end

    protected

    def download(url)
      uri = URI(url)

      filename = url.split('/').last
      path = "#{ULS.configuration.tmpdir}/#{filename}"
      Net::HTTP.start(uri.host, uri.port, use_ssl: true ) do |http|
        request = Net::HTTP::Get.new uri

        http.request request do |response|
          open path, 'w' do |io|
            response.read_body do |chunk|
              io.write chunk
            end
          end
        end
      end

      path
    end
  end
end
