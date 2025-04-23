require './lib/auction'
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
end