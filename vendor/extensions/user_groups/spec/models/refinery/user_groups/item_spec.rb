require 'spec_helper'

module Refinery
  module UserGroups
    describe Item do
      describe "validations" do
        subject do
          FactoryGirl.create(:item)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
