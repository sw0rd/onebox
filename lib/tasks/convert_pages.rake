desc "Convert Page data from okshon"
task :convert_pages => :environment do
  begin
    # puts "converting page data from okshon"
    db = Mysql::real_connect('localhost', 'root', 'mysql', 'okshon_dev')
    
    def convert_flexinode(db, type, field_id)
      ec = Encoding::Converter.new("euc-jp", "utf-8")

      res = db.query("select n.nid, n.title, d.textual_data from node n join flexinode_data d on n.nid=d.nid where type='#{type}' and d.field_id=#{field_id}")
      res.each_hash do |row|
        title, url = row['title'], row['textual_data']
        puts title
        page = Page.find_or_create_by_name(title)
        if category = url.match(/(\d+)-category-leaf/)
          page.category = category.to_s.gsub(/-category-leaf/,'')
        end
        if query = url.match(/desc=[^&]*/)
          euc = query.to_s.gsub(/desc=/, '')
          page.query = ec.convert(CGI::unescape(euc))
        end
        if auccat = url.match(/auccat=\d+/)
          page.category = auccat.to_s.gsub(/auccat=/, '')
        end
        page.url = url
        page.save
      end
    end
    
    convert_flexinode(db, 'flexinode-1', 3)
    convert_flexinode(db, 'flexinode-2', 5)
    
  rescue Mysql::Error => e
    puts "Error message: #{e.error}"
  ensure
    db.close
  end
end