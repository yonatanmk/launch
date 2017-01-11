class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :author, presence: true
  validates :rating, inclusion: 0..100, numericality: true, allow_blank: true

  has_many :checkouts
  has_many :readers, through: :checkouts
  has_many :categorizations
  has_many :categories, through: :categorizations
end
