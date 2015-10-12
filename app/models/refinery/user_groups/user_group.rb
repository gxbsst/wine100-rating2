module Refinery
  module UserGroups
    class UserGroup < Refinery::Core::BaseModel
      self.table_name = 'refinery_user_groups'

      attr_accessible :name, :position

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true

      has_many :items, :class_name => 'Refinery::UserGroups::Item', :foreign_key => :refinery_user_group_id
    end
  end
end
