require './lib/item'
require 'rspec'

RSpec.describe Item do 
    describe 'instantiation' do
        it 'exists' do
            item = Item.new('Chalkware Piggy Bank')

            expect(item).to be_a(Item)
        end

        it 'has attributes: name, bids' do
            item = Item.new('Chalkware Piggy Bank')

            expect(item.name).to eq('Chalkware Piggy Bank')
            expect(item.bids).to eq({})
        end
    end
end