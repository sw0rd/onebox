class Country < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :iso_name
  
  def to_s
    name
  end
end
