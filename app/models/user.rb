class User < ActiveRecord::Base
  has_secure_password

  has_many :housing_assignments
  has_many :houses, through: :housing_assignments
  has_many :messages, through: :housing_assignments
  has_many :events, through: :housing_assignments
  has_many :chore_logs
  has_many :chores, through: :chore_logs
  has_many :issues
  has_many :user_promises

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, :uniqueness => true, :format => /.+@.+\..+/
  validates :password, :length => { :minimum => 6 }
end
