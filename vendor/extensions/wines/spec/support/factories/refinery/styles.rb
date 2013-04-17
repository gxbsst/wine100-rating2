
FactoryGirl.define do
  factory :style, :class => Refinery::Styles::Style do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

