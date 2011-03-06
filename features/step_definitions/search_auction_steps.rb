Given /^I have page titled (.+)$/ do |title|
  p = Page.create!(:name => title, :query => title)
end


When /^I search for (.+)$/ do |title|
  visit path_to("search #{title}")
end

Given /^I have page with category Car Documents \- Toyota \- Mark II$/ do
  p = Page.create!(:name => 'Car Documents - Toyota - Mark II', :category => '2084016551')  
end





