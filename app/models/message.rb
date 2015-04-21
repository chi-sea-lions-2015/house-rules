class Message < ActiveRecord::Base
  belongs_to :house

  validates :content, :length => { :minimum => 2 }
end
