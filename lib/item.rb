class Item

  attr_reader :name, :bids

  def initialize(name)
    @bids = {}
    @name = name
  end

  def add_bid(attendee, amount_bid)
    @bids[attendee] = amount_bid
  end

  def current_high_bid
    @bids.max_by do |attendee, amount_bid|
      amount_bid
    end&.last
  end


end