class Message < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :house
end
