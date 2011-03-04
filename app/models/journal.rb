class Journal < ActiveRecord::Base
  belongs_to :account, :class_name => "Account", :foreign_key => "account_id"
  
  def self.post(code, opts)
    
    transaction do
      last_entry = self.where(:account_id => opts[:account_id]).last
      last_balance = last_entry.nil? ? 0 : last_entry.balance
    
      journal = new(opts.merge(:code => code))      
      if code == 'DR'
        journal.balance = last_balance + opts[:amount]
      elsif code == 'CR'
        journal.balance = last_balance - opts[:amount]
      end
      account = Account.find(opts[:account_id])
      account.balance = journal.balance
      account.save
      journal.save      
    end
  end
  
end
