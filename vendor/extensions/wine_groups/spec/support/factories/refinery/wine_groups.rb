
FactoryGirl.define do
  factory :wine_group, :class => Refinery::WineGroups::WineGroup do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

