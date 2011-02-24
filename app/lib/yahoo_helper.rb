module YahooHelper
  def yahoo_auction_details(auction_id)
    "http://auctions.yahooapis.jp/AuctionWebService/V2/auctionItem?auctionID=#{auction_id}&appid=#{YAHOO_API}"
  end

  def yahoo_search_by_query(query, page=1)
    "http://auctions.yahooapis.jp/AuctionWebService/V2/search?query=#{CGI::escape(query)}&appid=#{YAHOO_API}&page=#{page}"
  end
  
  def yahoo_search_by_category(category, page=1)
    "http://auctions.yahooapis.jp/AuctionWebService/V2/categoryLeaf?appid=#{YAHOO_API}&category=#{category}&page=#{page}"
  end  

end
