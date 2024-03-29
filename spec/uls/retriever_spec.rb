require 'tmpdir'
require 'net/http'

module ULS
  RSpec.describe Retriever do
    before do
      ULS.configure do |config|
        config.tmpdir = "#{Dir.tmpdir}/uls-#{Time.now.to_i}"
      end
      FileUtils.mkdir_p(ULS.configuration.tmpdir)

      base_daily_url = "https://data.fcc.gov/download/pub/uls/daily/"
      stub_request(:get, /#{base_daily_url}.*/).
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host'=>'data.fcc.gov',
          }).
          to_return(status: 200, body: "testing", headers: {})

      base_weekly_url = "https://data.fcc.gov/download/pub/uls/complete/"
      stub_request(:get, /#{base_weekly_url}.*/).
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host'=>'data.fcc.gov',
          }).
          to_return(status: 200, body: "testing", headers: {})
    end

    after do
      FileUtils.rm_rf(ULS.configuration.tmpdir)
    end

    describe '#daily' do
      let(:retriever) { ULS::Retriever.amateur_radio }
      let(:mock_stream) { StringIO.new('testing') }

      context 'without a day specified' do
        it "downloads yesterday's file" do
          day = Date.new.prev_day

          abbreviated_day = Date::ABBR_DAYNAMES[day.wday].downcase
          url = "#{Retriever::DAILY_BASE_URL}/a_am_#{abbreviated_day}.zip"

          retriever.daily(:applications)

          filename = File.basename(url)
          filepath = "#{ULS.configuration.tmpdir}/#{filename}"

          expect(File.exist?(filepath)).to be true
          expect(File.read(filepath)).to eql('testing')
        end
      end

      context 'with a day specified' do
        { licenses: "#{Retriever::DAILY_BASE_URL}/l_am",
          applications: "#{Retriever::DAILY_BASE_URL}/a_am" }.each do |type, url_fragment|

            Date::DAYNAMES.each_with_index do |day, index|
              it "downloads the daily file for #{type} from #{day}" do
                abbreviated_day = day.downcase[0..2]
                url = "#{url_fragment}_#{abbreviated_day}.zip"

                retriever.daily(type, index)

                filename = File.basename(url)
                filepath = "#{ULS.configuration.tmpdir}/#{filename}"

                expect(File.exist?(filepath)).to be true
                expect(File.read(filepath)).to eql('testing')
              end
            end
          end
      end
    end

    describe '#weekly' do
      let(:retriever) { ULS::Retriever.amateur_radio }
      let(:mock_stream) { StringIO.new('testing') }

      { licenses: "#{Retriever::WEEKLY_BASE_URL}/l_amat.zip",
        applications: "#{Retriever::WEEKLY_BASE_URL}/a_amat.zip" }.each do |type, url|
          it "downloads the weekly file for #{type}" do
            retriever.weekly(type)

            filename = File.basename(url)
            filepath = "#{ULS.configuration.tmpdir}/#{filename}"

            expect(File.exist?(filepath)).to be true
            expect(File.read(filepath)).to eql('testing')
          end
        end
    end
  end
end
