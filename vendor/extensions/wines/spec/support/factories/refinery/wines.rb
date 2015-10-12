
FactoryGirl.define do
  factory :wine, :class => Refinery::Wines::Wine do
    sequence(:name_zh) { |n| "refinery#{n}" }
  end
end

