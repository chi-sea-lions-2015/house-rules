class Issue < ActiveRecord::Base
  belongs_to :issuable, polymorphic: true
  belongs_to :user
end
