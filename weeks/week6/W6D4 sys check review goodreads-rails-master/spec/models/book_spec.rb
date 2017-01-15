require "rails_helper"

describe Book do

  let(:roots) { FactoryGirl.create(:book) }

  it { should have_valid(:isbn).when("1234567890123") }
  it { should_not have_valid(:isbn).when("23456789012") }
  it { should_not have_valid(:isbn).when("aaaaaaaaaaaaa") }

  it "has a title" do
    expect(roots.title).to_not be_nil
  end

  it "has an author" do
    expect(roots.author).to_not be_nil
  end

  it "has an numberic, 13 digit isbn" do
    expect(roots.isbn).to_not be_nil
    expect(roots.isbn.length).to eq 13
    expect(roots.isbn).to_not be_nil

  end
end
