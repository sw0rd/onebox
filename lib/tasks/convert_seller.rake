require 'custom_string'

desc "Convert seller data from okshon"
task :convert_seller => :environment do
  begin    
    ignore = %w{na jp}
    db = Mysql::real_connect('localhost', 'root', 'mysql', 'okshon_dev')
    res = db.query("select seller from jpa_bid group by seller having(count(seller)>10) order by count(seller) desc")
    res.each_hash do |row|
      name = row['seller']
      unless name.is_email? or ignore.index(name)
        seller = Seller.find_or_create_by_name(name) 
        seller.page = Page.new(:name => name)
      end
    end
  rescue Mysql::Error => e
    puts "Error message: #{e.error}"
  ensure
    db.close
  end
end