class User < ActiveRecord::Base
  has_secure_password

  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "75x75#" }, :default_url => "/house-rules/app/assets/images/missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :messages
  has_many :housing_assignments
  has_many :houses, through: :housing_assignments
  has_many :events, through: :housing_assignments
  has_many :chore_logs
  has_many :chores, through: :chore_logs
  has_many :issues
  has_many :user_promises

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  # validates :email, :uniqueness => true, :format => /.+@.+\..+/
  validates :password, :length => { :minimum => 6 }
end
