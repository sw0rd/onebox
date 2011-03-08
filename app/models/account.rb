class Account < ActiveRecord::Base
  belongs_to :user
  has_many :journals, :dependent => :destroy
    
  accepts_nested_attributes_for :journals
  
  def withdraw(amount)
    if amount > balance
      credit(:amount => amount, :description => 'Pending withdrawal')
    else
      false
    end
  end
  
  def deposit(amount, reference)
    debit(:amount => amount, :description => "Deposit received. Ref: #{reference}")
  end
  
  def refund
    
  end
  
  def settle(bid)
    amount = bid.auction.closed_price
    if amount > balance
      credit(:amount => amount, :description => "Settle payment of #{bid.auction.code}", :ref => bid.id)
    else
      false
    end
  end
  
  def debit(opts = {})
    journal = journals.new(opts.merge({:account_id => id, :code => 'DR'}))
    journal.post
  end
  
  def credit(opts = {})
    journal = journals.new(opts.merge({:account_id => id, :code => 'CR'}))
    journal.post
  end
  
  def power_up(amount)
    update_attribute(:power, power+amount)
  end
  
  def power_down(amount)
    update_attribute(:power, power-amount)
  end

  def balance=(amount)
    write_attribute(:balance, amount)
    power = (amount.to_money.exchange_to(:JPY)*0.95).to_f.floor -   # exchange to YEN by google
            user.bids.bidding.sum(:bid_price)                       # deduct current bid
    write_attribute(:power, power)
  end


end
