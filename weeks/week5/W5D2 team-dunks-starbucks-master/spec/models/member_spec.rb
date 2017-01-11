require 'spec_helper'

describe Member do

  let(:jeff) { FactoryGirl.create(:member) }
  let(:melissa) { FactoryGirl.create(:member) }
  let(:sam) { FactoryGirl.create(:member, name: "Sam") }
  let(:suzi) { FactoryGirl.create(:member, team: "Starbucks") }

  it "has a name" do
    expect(jeff.name).to_not be_nil
    expect(melissa.name).to_not be_nil
    expect(sam.name).to eq "Sam"
  end

  it "has a team" do
    expect(jeff.team).to_not be_nil
    expect(melissa.team).to_not be_nil
    expect(suzi.team).to eq "Starbucks"
  end

  it "has a hot or iced preference" do
    expect(jeff.hot_or_iced).to_not be_nil
    expect(melissa.hot_or_iced).to_not be_nil
  end

end
