require 'rails_helper'

# RSpec.describe Recipe, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Recipe do
  describe ".quick_recipes" do
    it "returns recipes with a cooking time less than 30 min" do
      first_quick_recipe = create(:recipe, cooking_time: 5)
      second_quick_recipe = create(:recipe, cooking_time: 4)
      long_recipe = create(:recipe, cooking_time: 240)

      results = Recipe.quick_recipes

      expect(results).to include(first_quick_recipe)
      expect(results).to include(second_quick_recipe)
      expect(results).to_not include(long_recipe)
    end
  end
end
