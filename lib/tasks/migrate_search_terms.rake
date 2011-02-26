desc "Migrating search terms from okshon"
task :migrate_search_terms => :environment do
  begin
    db = Mysql::real_connect('localhost', 'root', 'mysql', 'okshon_dev')
    ec = Encoding::Converter.new("euc-jp", "utf-8")

    Page.delete_all(:pagetype => 1)
    res = db.query("select distinct message from watchdog where type='search'")
    res.each_hash do |row|
      row['message'].match(/<em>[^<]*<\/em>/) do |message| 
        query = message.to_s.gsub(/<\/{0,1}em>/, '') 
        query = query.gsub(/\*/, '').gsub(/ /, '+')
        puts query
        
        page = Page.find_or_create_by_query(query)
        page.update_attributes(:name => "Auction related to #{query}", :pagetype => 1)
        page.save
      end
    end
    
  rescue Mysql::Error => e
    puts "Error message: #{e.error}"
  ensure
    db.close
  end
end