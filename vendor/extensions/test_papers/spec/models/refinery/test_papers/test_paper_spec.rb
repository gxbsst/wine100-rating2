require 'spec_helper'

module Refinery
  module TestPapers
    describe TestPaper do
      describe "validations" do
        subject do
          FactoryGirl.create(:test_paper,
          :score => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:score) { should == "Refinery CMS" }
      end
    end
  end
end
