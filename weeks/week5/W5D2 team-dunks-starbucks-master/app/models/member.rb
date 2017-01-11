class Member < ActiveRecord::Base
  validates :name, presence: true
  validates :team, presence: true
end
