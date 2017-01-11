class Song < ActiveRecord::Base
  validates :year, numericality: true, length: { in: 2..4,
    message: "year must be 2-4 digits" }
end
