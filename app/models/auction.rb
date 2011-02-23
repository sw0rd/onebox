class Auction < ActiveRecord::Base
  belongs_to :page
  
  def self.columns() @columns ||= []; end
  
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :page_id,               :integer
  column :title,                 :string
  column :auction_id,            :string
  column :url,                   :string
  column :image_icon,            :string
  column :seller,                :string
  column :closed_date,           :datetime
  column :closed_price,          :decimal
  column :buy_price,             :decimal
  column :current_price,         :decimal
  column :description,           :text
  column :location,              :string
  column :rating,                :integer
  column :start_time,            :datetime
  column :end_time,              :datetime
end
