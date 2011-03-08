require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "firstname and lastname should be not null" do
    addr = Address.new
    assert !addr.save
  end
  
  test "address2 can be null" do
    addr = Address.new(:firstname => Faker::Name.first_name,
                       :lastname => Faker::Name.last_name,
                       :address1 => Faker::Address.street_address,
                       :city => Faker::Address.city,
                       :zipcode => Faker::Address.zip_code,
                       :phone => Faker::PhoneNumber.phone_number)
    addr.country = Country.find(rand(Country.count))
    assert addr.save
  end
  
  
  test "fullname should be firstname lastname" do
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    addr = Address.new(:firstname => firstname, :lastname => lastname)
    assert addr.fullname == "#{firstname} #{lastname}"
  end
end
