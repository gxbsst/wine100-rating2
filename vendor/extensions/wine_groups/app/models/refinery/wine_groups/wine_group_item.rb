module Refinery
  module WineGroups
    class WineGroupItem < Refinery::Core::BaseModel

      belongs_to :wine_group, :class_name => '::Refinery::WineGroups::WineGroup', :foreign_key => :group_id
      belongs_to :wine, :class_name => 'Refinery::Wines::Wine', :foreign_key => :wine_id

      attr_accessible :wine_id, :group_id, :position

      delegate :name, :to => :wine_group
      delegate :name_en, :name_zh, :vingate, :to => :wine
      # def title was created automatically because you didn't specify a string field
      # when you ran the refinery:engine generator. <3 <3 Refinery CMS.
      def title
        "Override def title in vendor/extensions/wine_groups/app/models/refinery/wine_groups/wine_group_item.rb"
      end
    end
  end
end
