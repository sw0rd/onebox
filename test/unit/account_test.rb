require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "should debit transactions" do
    user = create_test_user
    10.times { user.account.debit(:amount => rand*1000)}
    assert user.account.journals.count == 10
    assert user.account.balance == user.account.journals.last.balance
    assert user.account.journals.sum(:amount) == user.account.balance
  end

  test "should credit transactions" do
    user = create_test_user
    10.times { user.account.credit(:amount => rand*1000)}
    assert user.account.journals.count == 10
    assert user.account.balance == user.account.journals.last.balance
    assert user.account.balance < 0
    assert -user.account.journals.sum(:amount) == user.account.balance # sum of credit should be negative of account balance
  end

  test "should debit and credit" do
    user = create_test_user
    10.times do 
      amount = rand*1000-500
      if amount < 0
        user.account.credit(:amount => -amount)
      else
        user.account.debit(:amount => amount)
      end
    end
    assert user.account.journals.count == 10
    assert user.account.balance == user.account.journals.last.balance    
  end
  
  test "debit should increase account balance" do
    user = create_test_user
    amount = (rand*1000).floor
    assert user.account.balance == 0, "user account should be zero at first"
    user.account.debit(:amount => amount)
    assert user.account.balance == amount, "balance should be increased to #{amount}"   

    amount2 = (rand*1000).floor
    last_entry = user.account.journals.last
    user.account.debit(:amount => amount2)
    this_entry = user.account.journals.last
    assert user.account.balance == amount + amount2
    assert last_entry.balance + this_entry.amount == this_entry.balance, "#{last_entry.balance}+#{this_entry.amount} should be equal to #{this_entry.balance}"
  end

  test "credit should decrease account balance" do
    user = create_test_user
    amount = (rand*1000).floor
    assert user.account.balance == 0
    user.account.credit(:amount => amount)
    assert user.account.balance == -amount
    
    amount2 = (rand*1000).floor
    last_entry = user.account.journals.last
    user.account.credit(:amount => amount2)
    this_entry = user.account.journals.last
    assert user.account.balance == -amount - amount2
    assert user.account.balance < 0
    assert last_entry.balance - this_entry.amount = this_entry.balance
  end
  
  def create_test_user
    user = User.create!(:provider => 'twitter', :uid => Faker::Address.zip_code)
    assert user.account
    user
  end
end
