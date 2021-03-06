class User < ActiveRecord::Base
  has_one :account, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :journals, :through => :account
  has_many :orders, :dependent => :destroy
  has_many :bids, :dependent => :destroy
  
  # validates :email, :presence => true, :uniqueness => true, :email => true
  
  accepts_nested_attributes_for :account, :orders, :bids
  after_create :create_account, :create_profile

  default_scope where(:status => 1)
  scope :inactive, where(:status  => 0)

  delegate :balance,
           :power,
           :to => :account
  delegate :timezone,
           :grade,
           :to => :profile

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['user_info']['name']
    end
  end

  def self.find_with_provider(provider, uid)
    self.includes(:profile).includes(:account).find_by_provider_and_uid(provider, uid)
  end
  
  protected
  def create_account
    Account.create do |account|
      account.user = self
    end
  end
  
  def create_profile
    Profile.create do |profile|
      profile.user = self
    end
  end
end
