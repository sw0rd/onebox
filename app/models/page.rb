class Page < ActiveRecord::Base
  include YahooHelper
  
  attr_accessible :name, :url, :body, :query, :category
  attr_accessor :auctions
  
  def update_yahoo
    url = yahoo_search_by_query(query) unless query.nil?
    url = yahoo_search_by_category(category) unless category.nil?
    doc = Nokogiri::XML(open(url))
    parse_search_result(doc)
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
