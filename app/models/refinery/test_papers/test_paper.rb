module Refinery
  module TestPapers
    class TestPaper < Refinery::Core::BaseModel
      self.table_name = 'refinery_test_papers'

      attr_accessible :wine_id, :user_id, :group_id, :score, :drink_begin_at, :drink_end_at, :note, :position

      acts_as_indexed :fields => [:score, :note]

      validates :score, :presence => true
      validates :drink_begin_at, :drink_end_at, :length => { :is => 4 }, :numericality => { :only_integer => true }
      belongs_to :wine_group_item, :class_name => 'Refinery::WineGroups::WineGroupItem', :foreign_key => :group_item_id

      scope :fetch, lambda {|wine_id| where(:wine_id => wine_id)}
    end
  end
end
