require './lib/auction'
require './lib/item'
require './lib/attendee'
require 'rspec'

RSpec.describe Auction do
    describe 'instantiation' do
        it 'exists' do
            auction = Auction.new

            expect(auction).to be_a(Auction)
        end 

        it 'has attributes' do
            auction = Auction.new

            expect(auction.items).to eq([])
        end
    end

    describe '#add_item' do
        it 'can add items to the @items array' do
            auction = Auction.new
            item1 = Item.new('Chalkware Piggy Bank')
            item2 = Item.new('Bamboo Picture Frame')

            auction.add_item(item1)
            auction.add_item(item2)

            expect(auction.items).to eq([item1, item2])
        end
    end

    describe '#item_names' do
        it 'can return the names of all the items in the @items array' do
            auction = Auction.new
            item1 = Item.new('Chalkware Piggy Bank')
            item2 = Item.new('Bamboo Picture Frame')

            auction.add_item(item1)
            auction.add_item(item2)

            expect(auction.item_names).to eq(['Chalkware Piggy Bank', 'Bamboo Picture Frame'])

        end
    end

    describe '#unpopular_items' do

        it 'can add items with no bids to a new array' do
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
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)

            expect(auction.unpopular_items).to eq([item2, item3, item4, item5])
        end

        it 'can remove items from the array once they have been bid on' do
            auction = Auction.new
            item1 = Item.new('Chalkware Piggy Bank')
            item2 = Item.new('Bamboo Picture Frame')
            item3 = Item.new('Homemade Chocolate Chip Cookies')
            item4 = Item.new('2 Days Dogsitting')
            item5 = Item.new('Forever Stamps')
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
            attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
            
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            
            expect(auction.unpopular_items).to eq([item2, item3, item5])

            item3.add_bid(attendee2, 15)

            expect(auction.unpopular_items).to eq([item2, item5])
        end
    end

    describe '#potential_revenue' do
        it 'can iterate over each item to calculate the sum of the highest bids' do
            auction = Auction.new
            item1 = Item.new('Chalkware Piggy Bank')
            item2 = Item.new('Bamboo Picture Frame')
            item3 = Item.new('Homemade Chocolate Chip Cookies')
            item4 = Item.new('2 Days Dogsitting')
            item5 = Item.new('Forever Stamps')
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
            attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
            
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)

            expect(auction.potential_revenue).to eq(87)
        end

    end
end