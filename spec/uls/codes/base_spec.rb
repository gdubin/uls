module ULS
  module Codes
    RSpec.describe Base do
      class DummyTestClassA < Base
        define_uls_code '', description: 'Blank Thing'
        define_uls_code 'A', description: 'Also Regular Thing'
      end

      class DummyTestClassB < Base
        define_uls_code 'B', description: 'Just Regular Thing'
      end

      describe '#define_uls_code' do
        it 'adds the code to the possible codes' do
          expect(DummyTestClassA.possible_codes.keys).to include('', 'A')
          expect(DummyTestClassB.possible_codes.keys).to include('B')
        end

        it 'creates question mark methods based on the description' do
          dummy = DummyTestClassA.new('A')
          
          expect(dummy).to respond_to(:blank_thing?)
          expect(dummy).to respond_to(:also_regular_thing?)
        end

        it 'configures the question mark methods to respond appropriately' do
          dummy = DummyTestClassA.new('A')

          expect(dummy.blank_thing?).to be false 
          expect(dummy.also_regular_thing?).to be true
        end
      end

      describe '#initialize' do
        context 'when one of the possible codes is blank/empty string' do
          it 'accepts a blank code' do
            dummy = DummyTestClassA.new('')
            
            expect(dummy).to be_an_instance_of(DummyTestClassA)
          end
        end

        context 'when one of the possibe codes is not blank/empty string' do
          it 'raises an exception' do
            expect { DummyTestClassB.new('') }.to raise_exception(ArgumentError)
          end
        end
      end

      describe '#description' do
        it 'returns nil if no code is set' do
          dummy = DummyTestClassA.new
          expect(dummy.description).to be nil
        end

        it 'returns the appropriate description if the code is set' do
          dummy = DummyTestClassA.new('A')
          expect(dummy.description).to eql('Also Regular Thing')
        end
      end
    end
  end
end
