require './lib/auction'
require './lib/item'
require './lib/attendee'
require 'rspec'

RSpec.describe Auction do

    # was trying to experiment with `let` statements here to avoid repetition
    # and to do so more efficiently than before(each) statements within each describe blockbut
    # not sure if I did it correctly, will bring this up during the review
    
    let(:auction) { Auction.new }
    let(:item1) { Item.new('Chalkware Piggy Bank') }
    let(:item2) { Item.new('Bamboo Picture Frame') }
    let(:item3) { Item.new('Homemade Chocolate Chip Cookies') }
    let(:item4) { Item.new('2 Days Dogsitting') }
    let(:item5) { Item.new('Forever Stamps') }
    let(:attendee1) { Attendee.new({name: 'Megan', budget: '$50'}) }
    let(:attendee2) { Attendee.new({name: 'Bob', budget: '$75'}) }
    let(:attendee3) { Attendee.new({name: 'Mike', budget: '$100'}) }
        
    describe 'instantiation' do
        it 'exists' do
            expect(auction).to be_a(Auction)
        end 

        it 'has attributes' do
            expect(auction.items).to eq([])
        end
    end

    describe '#add_item' do
        it 'can add items to the @items array' do

            auction.add_item(item1)
            auction.add_item(item2)

            expect(auction.items).to eq([item1, item2])
        end
    end

    describe '#item_names' do
        it 'can return the names of all the items in the @items array' do

            auction.add_item(item1)
            auction.add_item(item2)

            expect(auction.item_names).to eq(['Chalkware Piggy Bank', 'Bamboo Picture Frame'])
        end
    end

    describe '#unpopular_items' do

        before(:each) do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)
        end

        it 'can add items with no bids to a new array' do
        
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)

            expect(auction.unpopular_items).to eq([item2, item3, item4, item5])
        end

        it 'can remove items from the array once they have been bid on' do
         
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            
            expect(auction.unpopular_items).to eq([item2, item3, item5])

            item3.add_bid(attendee2, 15)

            expect(auction.unpopular_items).to eq([item2, item5])
        end
    end

    describe '#potential_revenue' do

        before(:each) do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)
        end

        it 'can calculate the the sum of each items highest bid' do
                       
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)

            expect(auction.potential_revenue).to eq(87)
        end
    end

    describe '#bidders' do

        it 'can return an array of bidder names as a string' do
        
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)
            
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)
            
            bidder_names = auction.bidders.map { |attendee| attendee.name }
            
            expect(bidder_names).to match_array(["Megan", "Bob", "Mike"])
        end
    end

    describe '#bidder_info' do
        
       before(:each) do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)
        end
    
        it 'can return a hash' do
            expect(auction.bidder_info).to be_a(Hash)
        end

        it 'only includes attendees who have actually placed bids' do
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
        
            expect(auction.bidder_info.keys).to match_array([attendee1, attendee2])
        
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)
        
            expect(auction.bidder_info.keys).to match_array([attendee1, attendee2, attendee3])
          end

        it 'has a sub-hash for each attendee with keys :budget and :items' do
            item1.add_bid(attendee1, 22)
            item3.add_bid(attendee2, 15)
            item4.add_bid(attendee3, 50)
          
            bidder_info = auction.bidder_info
          
            expect(bidder_info[attendee1]).to be_a(Hash)
            expect(bidder_info[attendee1]).to have_key(:budget)
            expect(bidder_info[attendee1]).to have_key(:items)
          
            expect(bidder_info[attendee2]).to be_a(Hash)
            expect(bidder_info[attendee2]).to have_key(:budget)
            expect(bidder_info[attendee2]).to have_key(:items)
          
            expect(bidder_info[attendee3]).to be_a(Hash)
            expect(bidder_info[attendee3]).to have_key(:budget)
            expect(bidder_info[attendee3]).to have_key(:items)
        end
          
        it 'returns the correct budget for each attendee' do
            item1.add_bid(attendee1, 22)
            item3.add_bid(attendee2, 15)
            item4.add_bid(attendee3, 50)
          
            bidder_info = auction.bidder_info
          
            expect(bidder_info[attendee1][:budget]).to eq(50)
            expect(bidder_info[attendee2][:budget]).to eq(75)
            expect(bidder_info[attendee3][:budget]).to eq(100)
        end
            
        it 'includes only items an attendee has actually bid on' do
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)
        
            bidder_info = auction.bidder_info
        
            expect(bidder_info[attendee1][:items]).to contain_exactly(item1)
            expect(bidder_info[attendee2][:items]).to contain_exactly(item1, item3)
            expect(bidder_info[attendee3][:items]).to contain_exactly(item4)
        end         
    end


end