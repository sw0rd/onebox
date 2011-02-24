class Auction < ActiveRecord::Base
  include GoogleHelper
  has_many :images, :class_name => "AuctionImage", :foreign_key => "auction_id"
  attr_accessor :location  
  @location
  
  def time_left
    duration = (self.end_time - Time.now).floor
    return 'closed' if duration < 0
    duration = (duration/60).floor*60 if duration > 60
    duration = (duration/3600).floor*3600 if duration > 3600
    return ChronicDuration::output(duration, :format => :long)
  end
  
  def fetch_from_yahoo
    auction_url = "http://auctions.yahooapis.jp/AuctionWebService/V2/auctionItem?auctionID=#{auction_id}&appid=#{YAHOO_API}"
    page = Nokogiri::XML(open(auction_url))
    page.remove_namespaces!
    self.title = google_translate(page.xpath('//Title').inner_text.strip)
    self.seller = page.xpath('//Seller/Id').inner_text
    self.rating = page.xpath('//Seller/Rating/Point').inner_text
    
    1.upto 3 do |index|
      AuctionImage.find_or_create_by_image(:auction_id => self.id, :image => page.xpath("//Image#{index}").inner_text)
    end
    self.description = page.xpath('//Description').inner_text
    self.current_price = page.xpath('//Price').inner_text
    self.buy_price = page.xpath('//Bidorbuy').inner_text
    self.start_time = Time.parse(page.xpath('//StartTime').inner_text)
    self.end_time = Time.parse(page.xpath('//EndTime').inner_text)
    @location = page.xpath('//Location').inner_text    
    self.save
  end  
  
  # def to_param
  #   "#{auction_id}-#{title.gsub(/^a-z0-9/i, '-').downcase}"
  # end
  def to_param
    auction_id
  end
end
