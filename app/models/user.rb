class User < ActiveRecord::Base
  # validates_presence_of :email, :on => :create, :message => "can't be blank"
  has_one :account, :dependent => :destroy
  
  accepts_nested_attributes_for :account
  
  after_create :create_account  

  default_scope where(:status => 1)
  scope :inactive, where(:status  => 0)
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['user_info']['name']
    end
  end
  
  protected
  def create_account
    Account.create do |account|
      account.user = self
    end
  end
end
