class Account < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :journals, :dependent => :destroy
    
  accepts_nested_attributes_for :journals
  
  def debit(opts = {})
    journal = journals.new(opts.merge({:account_id => id, :code => 'DR'}))
    journal.post
    reload
  end
  
  def credit(opts = {})
    journal = journals.new(opts.merge({:account_id => id, :code => 'CR'}))
    journal.post
    reload
  end
  
  def balance=(amount)
    write_attribute(:balance, amount)
    write_attribute(:power, amount*75)  # TODO: change rate to system preference
  end
  
end
