require 'rails_helper'

RSpec.describe "pokemons/new", type: :view do
  before(:each) do
    assign(:pokemon, Pokemon.new(
      :name => "MyString"
    ))
  end

  it "renders new pokemon form" do
    render

    assert_select "form[action=?][method=?]", pokemons_path, "post" do

      assert_select "input#pokemon_name[name=?]", "pokemon[name]"
    end
  end
end
