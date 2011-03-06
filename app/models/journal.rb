class Journal < ActiveRecord::Base
  belongs_to :account, :class_name => "Account", :foreign_key => "account_id"
  
  def post()    
    transaction do
      last_balance = account.journals.last.nil? ? 0 : account.journals.last.balance
      if code == 'DR'
        self.balance = last_balance + amount
      else
        self.balance = last_balance - amount
      end
      account.balance = balance
      account.save
      save      
    end
  end
  
end
