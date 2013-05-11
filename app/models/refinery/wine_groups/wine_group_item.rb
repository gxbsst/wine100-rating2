module Refinery
  module WineGroups
    class WineGroupItem < Refinery::Core::BaseModel

      belongs_to :wine_group, :class_name => '::Refinery::WineGroups::WineGroup', :foreign_key => :group_id
      belongs_to :wine, :class_name => 'Refinery::Wines::Wine', :foreign_key => :wine_id
      has_many :test_papers, :class_name => 'Refinery::TestPapers::TestPaper', :foreign_key => :group_item_id

      attr_accessible :wine_id, :group_id, :position, :wine_group_id

      delegate :name, :to => :wine_group
      delegate :name_en, :name_zh, :vingate, :uuid, :to => :wine

      def test_paper(user)
        Refinery::TestPapers::TestPaper.find_or_initialize_by_user_id_and_wine_id_and_group_id_and_wine_group_id(user.id,
                                                                                                                 self.wine_id,
                                                                                                                 self.group_id,
                                                                                                                 wine_group.id
        )
      end

      # def title was created automatically because you didn't specify a string field
      # when you ran the refinery:engine generator. <3 <3 Refinery CMS.
      def title
        "Override def title in vendor/extensions/wine_groups/app/models/refinery/wine_groups/wine_group_item.rb"
      end
    end
  end
end
