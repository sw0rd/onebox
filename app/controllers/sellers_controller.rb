class SellersController < ApplicationController
  def show
    @seller = Seller.find_or_create_by_name(params[:id])
  end
end
