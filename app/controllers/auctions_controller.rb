class AuctionsController < ApplicationController  
  def show
    begin
      @auction = Auction.find_or_create_by_code(params[:id])
      @auction.fetch_yahoo()
    rescue OpenURI::HTTPError
      redirect_to root_path
    end
  end
end
