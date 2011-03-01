class Page < ActiveRecord::Base
  include YahooHelper

  attr_accessible :name, :url, :body, :query, :category, :published
  attr_accessor :auctions
  
  acts_as_taggable

  default_scope where(:published => true)

  validates_presence_of :name, :on => :create, :message => "can't be blank"
  
  def fetch_yahoo
    begin
      # logger.debug yahoo_search(query, category)
      doc = Nokogiri::XML(open(yahoo_search(query, category)))
    rescue OpenURI::HTTPError # not found in yahoo
      update_attributes(:published => false)
      return false
    end
    parse_search_result(doc)
    true
  end

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-').downcase}"
  end

  private
  def parse_search_result(doc)
    doc.remove_namespaces!

    @auctions = Array.new
    doc.xpath('//Item').each do |item|
      @auctions << Auction.new(:auction_id => item.xpath('.//AuctionID').inner_text.strip, 
                               :title => item.xpath('.//Title').inner_text.strip,
                               :current_price => item.xpath('.//CurrentPrice').inner_text.strip.to_f,
                               :image_icon => item.xpath('.//Image').inner_text.strip)
    end
  end
end
