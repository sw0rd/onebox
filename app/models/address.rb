class Address < ActiveRecord::Base
  belongs_to :country
  
  validates :firstname, :lastname, :address1, :city, :zipcode, :country, :phone, :presence => true

  def fullname
    "#{firstname} #{lastname}"
  end
end
