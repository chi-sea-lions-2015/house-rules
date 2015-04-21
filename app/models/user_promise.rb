class UserPromise < ActiveRecord::Base
  belongs_to :promisable, polymorphic: true
end
