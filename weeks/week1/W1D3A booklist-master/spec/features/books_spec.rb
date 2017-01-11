require "spec_helper" # or
# require "rails_helper"

feature "template", focus: true do

  # User Story
  # ----------
  # As a user
  # I want to add book
  # So that I can remember to read it later

  # Acceptance Criteria
  # -------------------
  # * I must enter a title
  # * I must enter an author
  # * I must enter a genre

  before(:each) do
    CSV.open("data/books_test.csv", "w", headers: true) do |csv|
      csv << ["title", "author", "genre"]
    end
  end

  context "create" do
    scenario "user creates a book" do
      visit "/"

      click_on "New Book"

      fill_in "Title", with: "The Martian"
      fill_in "Author", with: "Andy Weir"
      fill_in "Genre", with: "Science Fiction"

      click_on "Submit"

      expect(page).to have_content("The Martian")
    end

    scenario "user leaves a field blank" do
      visit "/"

      click_on "New Book"
      fill_in "Author", with: "Andy Weir"
      fill_in "Genre", with: "Science Fiction"

      click_on "Submit"

      expect(page).to have_content("Please fill out all fields")
    end
  end

  xcontext "pending specs" do

    context "read" do
      scenario "user views a thing" do

      end
    end

    context "update" do
      scenario "user edits a thing" do

      end
    end

    context "delete" do
      scenario "user deletes a thing" do

      end
    end
  end
end
