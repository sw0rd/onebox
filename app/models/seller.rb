class Seller < ActiveRecord::Base    
  has_one :page, :dependent => :destroy
  accepts_nested_attributes_for :page
  
  def to_param
    name
  end
end
