class Page < ActiveRecord::Base
  attr_accessible :name, :url, :body, :query
end
