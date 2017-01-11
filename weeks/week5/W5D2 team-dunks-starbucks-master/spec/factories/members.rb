require 'factory_girl'
require 'spec_helper'

FactoryGirl.define do
  factory :member do
    sequence(:name) { |n| "Fred#{n}"}
    team "Dunks"
    hot_or_iced "iced"
  end
end
