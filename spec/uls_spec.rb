RSpec.describe ULS do
  it "has a version number" do
    expect(ULS::VERSION).not_to be nil
  end

  describe 'configuration' do
    it 'has base configuration' do
      expect(ULS.configuration).not_to be_nil 
    end

    it 'uses a block to allow changes' do
      ULS.configure do |config|
        config.tmpdir = '/opt/not/tmp'
      end

      expect(ULS.configuration.tmpdir).to eql('/opt/not/tmp')
    end
  end
end
