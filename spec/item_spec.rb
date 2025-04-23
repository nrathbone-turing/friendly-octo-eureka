require './lib/item'
require './lib/attendee'
require './lib/auction'
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

    describe '#add_bid' do
        it 'can receive an attendee and $ amount and return an array of hashes with key/value pairs of attendee and $ amount bid' do
            auction = Auction.new
            item1 = Item.new('Chalkware Piggy Bank')
            item2 = Item.new('Bamboo Picture Frame')
            item3 = Item.new('Homemade Chocolate Chip Cookies')
            item4 = Item.new('2 Days Dogsitting')
            item5 = Item.new('Forever Stamps')
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})

            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)

            item1.add_bid(attendee1, 22)
            item1.add_bid(attendee2, 20)

            expect(item1.bids).to eq ({attendee1 => 22, attendee2 => 20})
        end

    end
end