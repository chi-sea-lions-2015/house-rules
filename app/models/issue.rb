class Issue < ActiveRecord::Base
  belongs_to :issuable, polymorphic: true

  validates :reason, :length => { :minimum => 5 }
end
