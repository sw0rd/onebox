class Bid < ActiveRecord::Base
  belongs_to :auction, :class_name => "Auction", :foreign_key => "auction_id"
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  validates :bid_price, :presence => true, :numericality => true
  validates :auction_id, :presence => true
  validate :bid_price_cannot_be_lower_than_previous


  default_scope where(:active => true)
  scope :active, where(:active => true)
  scope :inactive, where(:active => false)
  scope :bidding, where(:status => 'bidding')
  scope :lost, where(:status => 'lost')
  scope :won, where(:status => 'won')
  

  def place(code, price, qty=1)
    self.auction = Auction.find_or_create_by_code(code)
    self.auction.fetch_yahoo
    self.bid_price = price
    self.save
  end
  
  def bid_price_cannot_be_lower_than_previous
    errors.add(:bid_price, "can't be lower than #{auction.current_price}") unless bid_price > auction.current_price
  end
end
