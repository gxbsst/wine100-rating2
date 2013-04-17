module Refinery
  module WineGroups
    class WineGroup < Refinery::Core::BaseModel

      self.table_name = 'refinery_wine_groups'

      attr_accessible :name, :judge_id, :position

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true

      has_many :wine_group_items, :class_name => 'Refinery::WineGroups::WineGroupItem', :foreign_key => :group_id
    end
  end
end
