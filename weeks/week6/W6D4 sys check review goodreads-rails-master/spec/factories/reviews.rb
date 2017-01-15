FactoryGirl.define do
  factory :review do
    rating 5
    sequence(:body) { |n| "Wow! Awesome Book! Life changing #{n}" }
  end
end
