class Auction
  include GoogleHelper
  include YahooHelper
  include ActiveModel::Validations

  attr_accessor :title, :auction_id, :url, :image_icon, :seller, :rating, :description
  attr_accessor :closed_date, :closed_price, :current_price, :buy_price
  attr_accessor :start_time, :end_time, :location, :images
  
  validates_presence_of :auction_id
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def time_left
    return 'invalid' if @end_time.nil?
    duration = (@end_time - Time.now).floor
    if duration < 0
      'closed'
    else
      duration = (duration/60).floor*60 if duration > 60
      duration = (duration/3600).floor*3600 if duration > 3600
      ChronicDuration::output(duration, :format => :long)
    end
  end

  def fetch_from_yahoo    
    page = Nokogiri::XML(open(yahoo_auction_details(@auction_id)))
    page.remove_namespaces!
    @title = google_translate(page.xpath('//Title').inner_text.strip)
    @seller = page.xpath('//Seller/Id').inner_text
    @rating = page.xpath('//Seller/Rating/Point').inner_text
    @images = Array.new
    1.upto 3 do |index|
      @images << page.xpath("//Image#{index}").inner_text
    end
    @description = page.xpath('//Description').inner_text
    @current_price = page.xpath('//Price').inner_text
    @buy_price = page.xpath('//Bidorbuy').inner_text
    @start_time = Time.parse(page.xpath('//StartTime').inner_text)
    @end_time = Time.parse(page.xpath('//EndTime').inner_text)
    @location = page.xpath('//Location').inner_text    
    true
  end  
  
  def to_param
    auction_id
  end
end
