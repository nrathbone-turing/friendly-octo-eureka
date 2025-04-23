class Auction

  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item| 
      item.name
    end
  end

  def unpopular_items
    @items.select do |item| 
      item.bids.empty? 
    end
  end

  def potential_revenue
    sum = 0

    @items.each do |item| 
      sum += item.current_high_bid.to_i
    end

    sum
  end

  def bidders
    bidders = []
  
    @items.each do |item|
      item.bids.each_key do |attendee|
        bidders << attendee
      end
    end
  
    bidders.uniq
  end  
  

  def bidder_info
    bidder_info = {}
  
    bidders.each do |attendee|
      bidder_items = @items.select do |item|
        item.bids.keys.include?(attendee)
      end      
  
      next if bidder_items.empty?
  
      bidder_info[attendee] = {
        budget: attendee.budget,
        items: bidder_items
      }
    end
  
    bidder_info
  end
  

end