require 'timecop'

module ULS
  RSpec.describe Database do
    describe '#initialize' do
      context 'when receiving a zip file' do
        let(:path) { "#{ULS.configuration.tmpdir}/uls.zip" }
        let(:temporary_zip_file) { Tempfile.new("#{path}") }

        before do
          temporary_zip_file.open
        end

        after do
          temporary_zip_file.unlink
        end

        subject { Database.new(path) }

        it 'sets compressed_file to this path' do
          expect(subject.compressed_file).to eql(path)
        end
      end

      context 'when receiving a directory' do
        let(:example_directory) { Dir.mktmpdir }

        after do
          FileUtils.remove_entry example_directory
        end

        subject { Database.new(example_directory) }

        it 'set extracted_path to this path' do
          expect(subject.extracted_path).to eql(example_directory)
        end
      end
    end

    describe '#extracted_path' do
      subject { Database.new('/path/to/uls.zip') }

      before do
        allow_any_instance_of(Database).to receive(:extract).with('/path/to/uls.zip')

        Timecop.freeze
      end

      after do
        Timecop.return
      end

      it 'returns a unique filepath' do
        seconds_since_epoch = Time.now.to_i

        expect(subject.extracted_path).to eql("#{ULS.configuration.tmpdir}/uls_#{seconds_since_epoch}")
      end
    end

    { name_and_addresses: 'EN',
      form_primary: 'HD',
      form_secondary: 'AD' }.each do |method, record_type|
        describe "##{method}" do
          let(:directory) { Dir.mktmpdir }
          let(:sample_line) { "#{record_type}|||||||||||||||||||||||" }
          let(:filename) { "#{directory}/#{record_type}.dat" }
          let!(:sample_file) do
            File.open(filename, 'w') do |f|
              f << sample_line
              f.close
            end
          end
          let(:database) { Database.new(directory) }

          subject { database.send(method) }

          after do
            FileUtils.rm_rf(directory)
          end

          it 'returns an instance of DatFile' do
            expect(subject.class).to eql(DatFile)
          end

          # Quick sanity check to make sure we're linked up to the file.
          # The testing of parsing/handling is done in the DatFile specs.
          it 'is linked to the correct file' do
            subject.each_line do |line|
              expect(line).to eql(sample_line)
            end
          end

          it 'gracefully handles a missing file' do
            File.delete(filename)

            count = 0
            subject.each_line { |_line| count += 1 }
            expect(count).to eql(0)
          end
        end
      end
  end
end
