class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :up_votes, numericality: true
  validates :down_votes, numericality: true
end
