class Auction < ActiveRecord::Base
  has_many :bids
  include GoogleHelper
  include YahooHelper
  
  attr_accessor :rating, :images

  validates :code, :presence => true, :uniqueness => true
  
  def self.create_with_item(item)
    new do |auction|
      auction.code = item['AuctionID']
      auction.title = item['Title']
      auction.current_price = item['CurrentPrice']
      auction.image_icon = item['Image']
    end
    # new(:auction_id => item['AuctionID'], :title => item['Title'], :current_price => item['CurrentPrice'], :image_icon => item['Image'])
  end

  def to_param
    code
  end

  def self.parse_search_result(buffer)
    auctions = {}

    doc = JSON.parse!(buffer.read.gsub(/^\((.*)\)$/,'\1'))

    auctions['total'] = doc['ResultSet']['@attributes']['totalResultsAvailable'].to_i
    auctions['returned'] = doc['ResultSet']['@attributes']['totalResultsReturned'].to_i
    auctions['first'] = doc['ResultSet']['@attributes']['firstResultPosition'].to_i
    auctions['auctions'] = []
    if auctions['returned'] == 1
      item = doc['ResultSet']['Result']['Item']
      auctions['auctions'] << Auction.create_with_item(item)
    elsif auctions['returned'] > 1
      doc['ResultSet']['Result']['Item'].each do |item|
        auctions['auctions'] << Auction.create_with_item(item)
      end
    end      
    auctions
  end

  def time_left
    return 'invalid' if self.end_time.nil?
    duration = (self.end_time - Time.now).floor
    if duration < 0
      'closed'
    else
      duration = (duration/60).floor*60 if duration > 60
      duration = (duration/3600).floor*3600 if duration > 3600
      ChronicDuration::output(duration, :format => :long)
    end
  end

  def fetch_yahoo
    url = yahoo_search(:code => code)
    puts "YAHOO = #{url}"
    doc = JSON.parse!(open(url).read.gsub(/^\((.*)\)$/,'\1'))
    
    item = doc['ResultSet']['Result']
    self.title = item['Title']
    self.seller = item['Seller']['Id']
    @rating = item['Seller']['Rating']['Point']
    @images = Array.new
    1.upto 3 do |index|
      @images << item['Img']["Image#{index}"] unless item['Img']["Image#{index}"].nil?
    end
    self.description = item['Description']
    self.current_price = item['Price']
    self.buy_price = item['Bidorbuy']
    self.start_time = Time.parse(item['StartTime'])
    self.end_time = Time.parse(item['EndTime'])
    self.location = item['Location']
    true
  end  
  
end
