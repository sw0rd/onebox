class AuctionsController < ApplicationController  
  def show
    begin
      @auction = Auction.find_or_create_by_auction_id(params[:id])
      @auction.fetch_from_yahoo
    rescue OpenURI::HTTPError
      redirect_to root_path
    end
  end
end
