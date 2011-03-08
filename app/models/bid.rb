class Bid < ActiveRecord::Base
  belongs_to :auction, :class_name => "Auction", :foreign_key => "auction_id"
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  validates :bid_price, :presence => true, :numericality => true
  validates :auction_id, :presence => true

  validate :bid_price_cannot_be_lower_than_previous_or_current
  validate :outbid_all_others
  validate :user_should_have_enough_power

  default_scope where(:active => true)
  scope :active, where(:active => true)
  scope :inactive, where(:active => false)
  scope :bidding, where(:status => 'bidding')
  scope :lost, where(:status => 'lost')
  scope :won, where(:status => 'won')
  
  
  def place(code, price, qty=1)
    self.auction = Auction.includes(:bids).where(:code => code).first
    self.auction.fetch_yahoo
    self.bid_price = price
    self.save
  end
  
  def won
    logger.debug("*** won bid #{id}")
    self.status = 'won'

    save(:validate => false) # bypass validation
  end
  
  def outbid(own_bid = false)
    logger.debug("=== outbid #{id}")
    self.status = 'lost'
    self.active = !own_bid      # remove bid if bidding against own bid
    
    # return bidding power to owner
    user.account.power_up bid_price

    # send notification email if it is not own bid
    # TODO
    
    
    save(:validate => false)  # bypass validation
  end
  
  protected
  
  def bid_price_cannot_be_lower_than_previous_or_current
    current_price = auction.bids.last.bid_price unless auction.bids.last.nil?
    current_price = [current_price, auction.current_price].max
    errors.add(:bid_price, "should be higher than #{current_price}") unless bid_price > current_price
  end

  def user_should_have_enough_power
    logger.debug '=== checking power'
    if bid_price < user.account.power
      user.account.power_down bid_price
    else
      errors.add(:bid_price, "should not be higher than #{user.account.power}. Please top up your account balance") 
    end
  end
  
  def outbid_all_others
    Auction.find_by_code(auction.code).bids.bidding.each do |bid|
      bid.outbid (user == bid.user)
    end
  end

end
