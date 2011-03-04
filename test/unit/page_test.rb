require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test "should be invalid without name" do
    page = Page.new
    assert !page.save, "Saved page without name"
  end
  
  test "should be valid with name" do
    assert Page.create!(:name => Faker::Name.name)
  end
  
  test "should be defaulted to published" do
    page = Page.create!(:name => Faker::Name.name)
    assert page.published
  end
end
