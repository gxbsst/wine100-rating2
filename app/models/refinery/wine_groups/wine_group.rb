module Refinery
  module WineGroups
    class WineGroup < Refinery::Core::BaseModel

      self.table_name = 'refinery_wine_groups'

      attr_accessible :name, :judge_id, :position, :state

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true

      has_many :wine_group_items, :class_name => 'Refinery::WineGroups::WineGroupItem', :foreign_key => :group_id, :include => :wine

      scope :complete, -> { where(:state => 'complete').order("updated_at DESC") }
      scope :cancel, -> { where(:state => 'cancel').order("updated_at DESC") }

      def complete?
       self.state == 'complete'
      end

      def cancel?
        self.state == 'cancel'
      end

    end
  end
end
