module ULS
  module Records
    RSpec.describe Entity do
      describe "#from_row" do
        let(:line){ 'EN|0|1|2|3|CE|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|B|23||08/18/2009' } 

        subject { Entity.new }

        context 'when given a line to parse' do
          before do
            subject.from_row(line)
          end

          Entity.fields.each_with_index do |field, index|
            it "parses #{field[:attribute]} as a numeric", if: field[:type] == :numeric do
              expect(subject.send(field[:attribute])).to eql(index)
            end

            it "parses #{field[:attribute]} as a string", if: field[:type] == :string do
              expect(subject.send(field[:attribute])).to eql(index.to_s)
            end
          end

          it 'parses status_date as a date' do
            expect(subject.status_date).to eql(Date.new(2009, 8, 18))
          end

          it 'parses the applicant_type into an ULS::Codes::ApplicantType' do
            expect(subject.applicant_type).to be_an_instance_of(ULS::Codes::ApplicantType)
            expect(subject.applicant_type.amateur_club?).to be true
          end

          it 'parses the status into an ULS::Codes::Status' do
            expect(subject.status).to be_an_instance_of(ULS::Codes::Status)
            expect(subject.status.active?).to be true
          end

          it 'parses the entity_type into an ULS::Codes::EntityType' do
            expect(subject.entity_type).to be_an_instance_of(ULS::Codes::EntityType)
            expect(subject.entity_type.transferee_contact?).to be true
          end
        end
      end
    end
  end
end
