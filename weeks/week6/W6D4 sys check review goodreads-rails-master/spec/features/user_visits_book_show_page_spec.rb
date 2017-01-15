require "rails_helper"

feature "user visits a book's show page" do
  let!(:kindred) { Book.create(title: "Kindred", author: "Octavia Butler", isbn: "5555555555555") }
  let(:other_book) { FactoryGirl.create(:book) }
  let!(:kindred_review) { FactoryGirl.create(:review, book: kindred) }
  let!(:other_review) { FactoryGirl.create(:review, book: other_book) }

  scenario "user sees a list of books" do
    visit '/'
    click_link 'Kindred'
    expect(page).to have_content(kindred.title)
    expect(page).to have_content(kindred.author)
    expect(page).to have_content(kindred.isbn)
  end

  scenario "user sees all of the reviews that belong to that book" do
    visit '/'
    click_link 'Kindred'
    expect(page).to have_content(kindred_review.rating)
    expect(page).to have_content(kindred_review.body)
  end

  scenario "user does not see reviews that do not belong to that book" do
    visit '/'
    click_link 'Kindred'
    expect(page).to_not have_content(other_review.body)
  end

  scenario "user sees a link to add a review" do
    visit '/'
    click_link 'Kindred'
    expect(page).to have_link "Add a Review"
  end
end
