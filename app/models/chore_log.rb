class ChoreLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :chore
end
