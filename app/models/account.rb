class Account < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :journals, :dependent => :destroy
  
  accepts_nested_attributes_for :journals
  
  def debit(opts = {})
    Journal.post('DR', opts.merge(:account_id => id))
    reload
  end
  
  def credit(opts = {})
    Journal.post('CR', opts.merge(:account_id => id))    
    reload
  end
end
