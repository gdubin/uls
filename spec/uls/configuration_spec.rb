module ULS
RSpec.describe Configuration do
  describe "#tmpdir" do
    subject { Configuration.new }

    it 'defaults to the system tmp directory' do
      expect(subject.tmpdir).to eql(Dir.tmpdir)
    end

    it 'can be overriden' do
      subject.tmpdir = '/not/your/tmp'
      expect(subject.tmpdir).to eql('/not/your/tmp')
    end
  end
end
end
