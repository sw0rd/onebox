require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create account when user create" do
    user = User.new(:provider => 'twitter', :uid => Faker::Address.zip_code)
    assert user.save
    assert user.account, "Account should be created"
  end
end
