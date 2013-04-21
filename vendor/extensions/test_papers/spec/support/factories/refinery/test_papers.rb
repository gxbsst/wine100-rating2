
FactoryGirl.define do
  factory :test_paper, :class => Refinery::TestPapers::TestPaper do
    sequence(:score) { |n| "refinery#{n}" }
  end
end

