Given /^I have page titled (.+)$/ do |title|
  p = Page.create!(:name => title, :query => title)
end

Given /^I have page with seller (.+)$/ do |seller|
  p = Page.new
  p.name = "Listing for #{seller}"
  p.seller = Seller.find_or_create_by_name(seller)
  p.save!
end


When /^I search for (.+)$/ do |title|
  visit path_to("search #{title}")
end

Given /^I have page with category Car Documents \- Toyota \- Mark II$/ do
  p = Page.create!(:name => 'Car Documents - Toyota - Mark II', :category => '2084016551')  
end

Given /^the following (.+) exists$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

When /^I follow image link "([^"]*)"$/ do |img_alt|
  find(:xpath, "//img[@alt = '#{img_alt}']/parent::a").click()
end





