require "rails_helper"

feature "user visits the index page" do
  let!(:kindred) { FactoryGirl.create(:book) }
  let!(:bad_feminist) { FactoryGirl.create(:book) }
  let!(:unaccustomed_earth) { FactoryGirl.create(:book) }

  scenario "user sees a list of books" do
    visit '/'
    expect(page).to have_content(kindred.title)
    expect(page).to have_content(bad_feminist.title)
    expect(page).to have_content(unaccustomed_earth.title)
  end
end
