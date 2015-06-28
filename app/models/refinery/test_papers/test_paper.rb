module Refinery
  module TestPapers
    class TestPaper < Refinery::Core::BaseModel
      self.table_name = 'refinery_test_papers'

      attr_accessible :wine_id, :user_id, :group_id, :score, :drink_begin_at, :drink_end_at, :note, :position, :group_item_id, :user_group_id

      acts_as_indexed :fields => [:score, :note]

      validates :score, :presence => true
      #validates :drink_begin_at, :drink_end_at, :length => { :is => 4 }, :numericality => { :only_integer => true }
      belongs_to :wine_group_item, :class_name => 'Refinery::WineGroups::WineGroupItem', :foreign_key => :group_item_id
      belongs_to :wine, :class_name => 'Refinery::Wines::Wine', :foreign_key => 'wine_id'
      belongs_to :user_group, :class_name => 'Refinery::UserGroups::UserGroup', :foreign_key => :user_group_id
      belongs_to :user, :class_name => '::User', :foreign_key => 'user_id'

      delegate :wine, :to => :wine_group_item

      scope :fetch, lambda {|wine_id| where(:wine_id => wine_id)}
      scope :fetch_for_group, lambda {|group_id| where(:group_id=> group_id)}
      scope :fetch_for_wine_group, lambda {|wine_group_id| where(:wine_group_id=> wine_group_id)}

      def drink_window
        "#{drink_begin_at} to #{drink_end_at}"
      end
    end
  end
end
