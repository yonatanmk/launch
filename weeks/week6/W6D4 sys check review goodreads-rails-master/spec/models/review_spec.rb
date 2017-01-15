require "rails_helper"

describe Review do

  let(:roots) { FactoryGirl.create(:book) }
  let(:roots_review) { FactoryGirl.create(:review, book: roots)}

  it { should have_valid(:rating).when(5) }
  it { should_not have_valid(:rating).when(7) }
  it { should_not have_valid(:rating).when("aaaaaaaaaaaaa") }
  it { should belong_to :book }

  it "has a rating rating" do
    expect(roots_review.rating).to_not be_nil
  end

  it "has a body" do
    expect(roots_review.body).to_not be_nil
  end

  it "has an numberic star rating between 1 and 5" do
    expect(roots_review.rating).to eq 5
  end
end
