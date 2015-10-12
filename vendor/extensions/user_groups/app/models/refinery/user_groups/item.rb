module Refinery
  module UserGroups
    class Item < Refinery::Core::BaseModel

      attr_accessible :refinery_member_id, :refinery_user_group_id, :position
      # def title was created automatically because you didn't specify a string field
      # when you ran the refinery:engine generator. <3 <3 Refinery CMS.
      def title
        "Override def title in vendor/extensions/user_groups/app/models/refinery/user_groups/item.rb"
      end
    end
  end
end
