module YahooHelper
  def yahoo_auction_details(auction_id)
    "http://auctions.yahooapis.jp/AuctionWebService/V2/auctionItem?auctionID=#{auction_id}&appid=#{YAHOO_API}"
  end

  def yahoo_search(query, category, page=1)
    if query.nil?
      yahoo_search_by_category(category, page)
    else
      yahoo_search_by_query(query, category, page)
    end
    
  end
  
  def yahoo_search_by_query(query, category, page=1)
    query = query.gsub(/\+/, ' \+')
    if category.nil?
      "http://auctions.yahooapis.jp/AuctionWebService/V2/search?query=#{CGI::escape(query)}&appid=#{YAHOO_API}&page=#{page}"
    else
      "http://auctions.yahooapis.jp/AuctionWebService/V2/search?query=#{CGI::escape(query)}&appid=#{YAHOO_API}&page=#{page}&category=#{category}"
    end
  end
  
  def yahoo_search_by_category(category, page=1)
    "http://auctions.yahooapis.jp/AuctionWebService/V2/categoryLeaf?appid=#{YAHOO_API}&category=#{category}&page=#{page}"
  end  

end
