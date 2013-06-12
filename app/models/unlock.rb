class Unlock < ActiveRecord::Base

  validates :name, presence: true

  translates :name, :description

end