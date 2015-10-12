module Refinery
  module UserGroups
    class Item < Refinery::Core::BaseModel

      attr_accessible :refinery_member_id, :refinery_user_group_id, :position


      belongs_to :member, :class_name => 'Refinery::Members::Member', :foreign_key => :refinery_member_id
      belongs_to :group, :class_name => 'Refinery::UserGroups::UserGroup', :foreign_key => :refinery_user_group_id


      delegate :name, :to => :member
      # def title was created automatically because you didn't specify a string field
      # when you ran the refinery:engine generator. <3 <3 Refinery CMS.
      def title
        "Override def title in vendor/extensions/user_groups/app/models/refinery/user_groups/item.rb"
      end
    end
  end
end
