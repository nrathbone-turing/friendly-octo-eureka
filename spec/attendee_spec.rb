require './lib/attendee'
require 'rspec'

RSpec.describe Attendee do
    describe 'instantiation' do
        it 'exists' do
            attendee = Attendee.new({name: 'Megan', budget: '$50'})

            expect(attendee).to be_a(Attendee)
        end

        it 'has attributes: name, budget' do
            attendee = Attendee.new({name: 'Megan', budget: '$50'})

            expect(attendee.name).to eq('Megan')
            expect(attendee.budget).to eq(50)
        end
    end 
end 