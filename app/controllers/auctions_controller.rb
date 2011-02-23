class AuctionsController < ApplicationController  
  def show
    @auction = Auction.find(params[:id])
    @auction = Auction.find_by_auction_id(params[:id]) if @auction.nil
    
  end
end
