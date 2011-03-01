class Seller < ActiveRecord::Base
  has_one :page
  
    
  def to_param
    name
  end
end
