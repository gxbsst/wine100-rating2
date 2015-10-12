module Refinery
  module WineGroups
    class WineGroup < Refinery::Core::BaseModel

      self.table_name = 'refinery_wine_groups'

      attr_accessible :name, :judge_id, :position

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
