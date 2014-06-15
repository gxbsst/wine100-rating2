class Award < ActiveRecord::Base
  attr_accessible :award, :final, :refinery_wine_groups_wine_group_item_id, :refinery_member_id, :wine_id, :group_id, :final_user_id
  belongs_to :member, :class_name => 'User', :foreign_key => 'refinery_member_id'
  belongs_to :wine_group_item, :class_name => 'Refinery::WineGroups::WineGroupItem'
  belongs_to :wine, :foreign_key => 'wine_id', :class_name => 'Refinery::Wines::Wine'
end
