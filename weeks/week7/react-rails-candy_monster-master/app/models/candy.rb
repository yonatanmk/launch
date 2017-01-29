class Candy < ActiveRecord::Base
  validates :name, presence: true
end
