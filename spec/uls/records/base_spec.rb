module ULS
  module Records
    RSpec.describe Base do
      describe '#convert' do
        it 'performs the conversion to code classes' do
          result = Base.new.send(:convert, 'A', ULS::Codes::LicenseStatus)
          
          expect(result).to be_an_instance_of(ULS::Codes::LicenseStatus)
          expect(result.code).to eql('A')
        end

        it 'performs the conversion to numerics' do
          result = Base.new.send(:convert, '42', :numeric)

          expect(result).to eql(42)
        end

        it 'performs the conversion to a date' do
          result = Base.new.send(:convert, '08/16/2019', :date)

          expect(result).to be_an_instance_of(Date)
        end

        it 'does nothing for a string' do
          result = Base.new.send(:convert, 'ABC', :string)

          expect(result).to eql('ABC')
        end

        it 'does nothing if no type specified' do
          result = Base.new.send(:convert, 'ABC', nil)

          expect(result).to eql('ABC')
        end
      end
    end
  end
end
