class User < ActiveRecord::Base
  # validates_presence_of :email, :on => :create, :message => "can't be blank"
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['user_info']['name']
    end
  end
end
