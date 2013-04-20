module Refinery
  module UserGroups
    class UserGroup < Refinery::Core::BaseModel
      self.table_name = 'refinery_user_groups'

      attr_accessible :name, :position

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
