class Page < ActiveRecord::Base
  attr_accessible :name, :url, :body, :query, :category
  attr_accessor :auctions
  
  has_many :auctions
  
  def update_yahoo
    @auctions = search_by_query(query) unless query.nil?
    @auctions = search_by_category(category) unless category.nil?
  end

  
  def search_by_query(query, page=1)
    search_url = "http://auctions.yahooapis.jp/AuctionWebService/V2/search?query=#{CGI::escape(query)}&appid=#{YAHOO_API}&page=#{page}"
    doc = Nokogiri::XML(open(search_url))
    parse_search_result(doc)
  end
  
  def search_by_category(category, page=1)
    category_url = "http://auctions.yahooapis.jp/AuctionWebService/V2/categoryLeaf?appid=#{YAHOO_API}&category=#{category}&page=#{page}"
    doc = Nokogiri::XML(open(category_url))
    parse_search_result(doc)
  end  

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-').downcase}"
  end

  private
  def parse_search_result(doc)
    doc.remove_namespaces!

    doc.xpath('//Item').each do |item|
      auction = Auction.find_or_create_by_auction_id(:auction_id => item.xpath('.//AuctionID').inner_text.strip)
      auction.update_attributes(:title => item.xpath('.//Title').inner_text.strip,
                                :current_price => item.xpath('.//CurrentPrice').inner_text.strip.to_f,
                                :image_icon => item.xpath('.//Image').inner_text.strip,
                                :page_id => self.id)
    end
  end
  
end
