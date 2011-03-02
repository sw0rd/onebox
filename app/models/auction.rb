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

  def self.create_with_item(item)
    new(:auction_id => item['AuctionID'], :title => item['Title'], :current_price => item['CurrentPrice'], :image_icon => item['Image'])
  end
  
  def to_param
    auction_id
  end

  def self.parse_search_result(buffer, format)
    auctions = {}

    if format == :xml
      doc = Nokogiri::XML(buffer)
      doc.remove_namespaces!
      doc.xpath('//Item').each do |item|
        auctions['auctions'] << Auction.new(:auction_id => item.xpath('.//AuctionID').inner_text.strip, 
                                           :title => item.xpath('.//Title').inner_text.strip,
                                           :current_price => item.xpath('.//CurrentPrice').inner_text.strip.to_f,
                                           :image_icon => item.xpath('.//Image').inner_text.strip)
      end
    elsif format == :json
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
    end
    auctions
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

  def fetch_yahoo(format = :json) 
    url = yahoo_search(:auction_id => @auction_id, :format => format)
    if format == :xml
      page = Nokogiri::XML(open(url))
      page.remove_namespaces!
      @title = google_translate(page.xpath('//Title').inner_text.strip)
      @seller = page.xpath('//Seller/Id').inner_text
      @rating = page.xpath('//Seller/Rating/Point').inner_text
      @images = Array.new
      1.upto 3 do |index|
        @images << page.xpath("//Image#{index}").inner_text unless page.xpath("//Image#{index}").empty?
      end
      @description = page.xpath('//Description').inner_text
      @current_price = page.xpath('//Price').inner_text
      @buy_price = page.xpath('//Bidorbuy').inner_text
      @start_time = Time.parse(page.xpath('//StartTime').inner_text)
      @end_time = Time.parse(page.xpath('//EndTime').inner_text)
      @location = page.xpath('//Location').inner_text    
      true
    elsif format == :json
      doc = JSON.parse!(open(url).read.gsub(/^\((.*)\)$/,'\1'))
      
      item = doc['ResultSet']['Result']
      @title = item['Title']
      @seller = item['Seller']['Id']
      @rating = item['Seller']['Rating']['Point']
      @images = Array.new
      1.upto 3 do |index|
        @images << item['Img']["Image#{index}"] unless item['Img']["Image#{index}"].nil?
      end
      @description = item['Description']
      @current_price = item['Price']
      @buy_price = item['Bidorbuy']
      @start_time = Time.parse(item['StartTime'])
      @end_time = Time.parse(item['EndTime'])
      @location = item['Location']
      true
    end
  end  

  
end
