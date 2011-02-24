class AuctionImage < ActiveRecord::Base
  belongs_to :auction, :class_name => "Auction", :foreign_key => "auction_id"
end
