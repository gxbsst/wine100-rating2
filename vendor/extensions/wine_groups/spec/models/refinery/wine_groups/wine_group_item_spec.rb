require 'spec_helper'

module Refinery
  module WineGroups
    describe WineGroupItem do
      describe "validations" do
        subject do
          FactoryGirl.create(:wine_group_item)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
