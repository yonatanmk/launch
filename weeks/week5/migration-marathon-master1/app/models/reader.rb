class Reader < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true

  has_many :checkouts
  has_many :books, through: :checkouts
  # has_many :categorizations
  # has_many :categories, through: :categorizations
end
