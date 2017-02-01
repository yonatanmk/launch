require 'rails_helper'

RSpec.describe "pokemons/edit", type: :view do
  before(:each) do
    @pokemon = assign(:pokemon, Pokemon.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit pokemon form" do
    render

    assert_select "form[action=?][method=?]", pokemon_path(@pokemon), "post" do

      assert_select "input#pokemon_name[name=?]", "pokemon[name]"
    end
  end
end
