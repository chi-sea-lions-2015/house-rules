class Picture < ActiveRecord::Base
  belongs_to :message

  has_attached_file :picture_content, :styles => { :medium => "300x300#" }
  validates_attachment_content_type :picture_content, :content_type => /\Aimage\/.*\Z/

end
