
FactoryGirl.define do
  factory :user_group, :class => Refinery::UserGroups::UserGroup do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

