module ULS
  RSpec.describe DatFile do
    let(:sample_line) { 'EN|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|08/18/2009' }
    let(:sample_file) do
      Tempfile.new('csv').tap do |f|
        f << sample_line
        f.close
      end
    end
    let(:dat_file) { DatFile.new(sample_file.path) }

    after do
      sample_file.unlink
    end

    describe '#record_class' do
      { 'EN' => Records::Entity,
        'HD' => Records::FormPrimary,
        'AD' => Records::FormSecondary }.each do |two_character_type, klass|
        it "returns a #{klass} for record type #{two_character_type}" do
          result = dat_file.send(:record_class, two_character_type)
          expect(result).to eql(klass)
        end
      end
    end

    describe '#each_line' do
      it 'passes each line to the block' do
        dat_file.each_line do |line|
          expect(line).to eql(sample_line)
        end
      end
    end

    describe '#each_record' do
      it 'parses each record into an appropriate object and passes it to the block' do
        dat_file.each_record do |record|
          expect(record.class).to be Records::Entity
          # Quick sanity check to make sure data was parsed.  We test the
          # parsing mechanism elsewhere.
          expect(record.unique_system_identifier).to eql(0)
        end
      end
    end
  end
end
