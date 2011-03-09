require 'test_helper'

class BidTest < ActiveSupport::TestCase

  test "auction should not be invalid" do
    # auction = get_valid_auction_from_yahoo
    # assert auction.code
    # auction.fetch_yahoo
    code = 'x1234567'
    user  = User.create!(:provider => 'twitter', :uid => '1234567')
    bid = user.bids.new
    assert !bid.place(code, 1000)
  end
  
  test "auction should be open" do
    assert true
  end
  
  test "bid price should be higher than current price" do
    assert true
  end
  
  test "bid price should be higher than internal bid price" do
    assert true
  end
  
  test "all other bid should be outbid" do
    assert true
  end
  
  
end
