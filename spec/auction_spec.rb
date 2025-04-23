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


end