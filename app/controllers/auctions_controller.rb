class AuctionsController < ApplicationController  
  def show
    begin
      @auction = Auction.new(:auction_id => params[:id])
      @auction.fetch_yahoo(:json)
    rescue OpenURI::HTTPError
      redirect_to root_path
    end
  end
end
