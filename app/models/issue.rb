class Issue < ActiveRecord::Base
  belongs_to :issuable, polymorphic: true
  belongs_to :creator, class_name: "User", foreign_key: :user_id

  validates :reason, :length => { :minimum => 5 }
end
