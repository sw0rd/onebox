class Page < ActiveRecord::Base
  include YahooHelper
  belongs_to :seller
  
  attr_accessible :name, :url, :body, :query, :category, :published
  attr_accessor :auctions
  
  acts_as_taggable

  default_scope where(:published => true)

  validates_presence_of :name, :on => :create, :message => "can't be blank"


  def fetch_yahoo(page = 1, format = :json)
    begin
      url = yahoo_search(:query => query, 
                         :category => category, 
                         :seller => self.seller ? self.seller.name : nil,
                         :page => page, :format => format)
      logger.debug "YAHOO ====== " + url
      buffer = open(url)
    rescue OpenURI::HTTPError # not found in yahoo
      update_attributes(:published => false)
      return false
    end
    @auctions = Auction.parse_search_result(buffer, format)
  end

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-').gsub(/\-$/, '').downcase}"
  end

end
