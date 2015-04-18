class Message < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :housing_assignment
end
