class Message < ActiveRecord::Base
  belongs_to :house
  belongs_to :author, class_name: "User", foreign_key: :user_id

  validates :content, :length => { :minimum => 2 }
end
