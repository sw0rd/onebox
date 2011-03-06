module YahooHelper
  
  def yahoo_search(opts = {})
    page = opts[:page] || 1
    format = opts[:format] || :json
    json = (format == :xml) ? '' : 'json/'
    category = opts[:category] || '0'
    if auction_id = opts[:code]
      "http://auctions.yahooapis.jp/AuctionWebService/V2/#{json}auctionItem?auctionID=#{auction_id}&appid=#{YAHOO_API}&callback="
    elsif seller = opts[:seller]
      "http://auctions.yahooapis.jp/AuctionWebService/V2/#{json}sellingList?appid=#{YAHOO_API}&sellerID=#{seller}&page=#{page}&callback="
    elsif opts[:query]
      query = opts[:query].gsub(/\+/, ' \+')
      "http://auctions.yahooapis.jp/AuctionWebService/V2/#{json}search?query=#{CGI::escape(query)}&appid=#{YAHOO_API}&page=#{page}&category=#{category}&callback="
    else
      "http://auctions.yahooapis.jp/AuctionWebService/V2/#{json}categoryLeaf?appid=#{YAHOO_API}&category=#{category}&page=#{page}&callback="
    end
  end

  # def yahoo_auction_details(auction_id, format = :xml)
  #   json = format == :xml ? '' : 'json/'
  #   "http://auctions.yahooapis.jp/AuctionWebService/V2/#{json}auctionItem?auctionID=#{auction_id}&appid=#{YAHOO_API}&callback="
  # end
  # 
  # 
  # def yahoo_search(query, category, page=1, format = :xml)
  #   if query.nil?
  #     yahoo_search_by_category(category, page, format)
  #   else
  #     yahoo_search_by_query(query, category, page, format)
  #   end
  #   
  # end
  # 
  # def yahoo_search_by_query(query, category, page=1, format = :xml)
  #   query = query.gsub(/\+/, ' \+''')
  #   json = format == :xml ? '' : 'json/'
  #   if category.nil?
  #     "http://auctions.yahooapis.jp/AuctionWebService/V2/#{json}search?query=#{CGI::escape(query)}&appid=#{YAHOO_API}&page=#{page}&callback="
  #   else
  #     "http://auctions.yahooapis.jp/AuctionWebService/V2/#{json}search?query=#{CGI::escape(query)}&appid=#{YAHOO_API}&page=#{page}&category=#{category}&callback="
  #   end
  # end
  # 
  # def yahoo_search_by_category(category, page=1, format = :xml)
  #   json = format == :xml ? '' : 'json/'
  #   "http://auctions.yahooapis.jp/AuctionWebService/V2/#{json}categoryLeaf?appid=#{YAHOO_API}&category=#{category}&page=#{page}&callback="
  # end  

  # def yahoo_search_by_seller(seller, page=1, format = :xml)
  #   json = format == :xml ? '' : 'json/'
  #   "http://auctions.yahooapis.jp/AuctionWebService/V2/#{json}sellingList?appid=#{YAHOO_API}&sellerID=#{seller}&page=#{page}&callback="
  # end
  
  
end
