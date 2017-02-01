class Pokemon < ApplicationRecord

  def self.spawn
    Pokemon.create(name: "Porkochu")
  end
end
