require 'rails_helper'

feature "visitors can add reviews for books" do
  let!(:beloved) { FactoryGirl.create(:book) }
  scenario "adds a review successfully" do

    visit book_path(beloved)
    click_link 'Add a Review'

    expect(page).to have_content "Review form for #{beloved.title}"

    fill_in "Rating", with: 3
    fill_in "Review", with: "Rave review"
    click_button "Add Review"

    expect(page).to have_content beloved.title
    expect(page).to have_content 5
    expect(page).to have_content "Rave review"
  end

  scenario "adds a review unsuccessfully" do
    visit book_path(beloved)
    click_link 'Add a Review'
    click_button 'Add Review'

    expect(page).to have_content "rating can't be blank, rating is not a number, rating is not included in the list, and Body can't be blank"
  end
end
