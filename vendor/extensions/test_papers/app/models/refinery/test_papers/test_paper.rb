module Refinery
  module TestPapers
    class TestPaper < Refinery::Core::BaseModel
      self.table_name = 'refinery_test_papers'

      attr_accessible :wine_id, :user_id, :group_id, :score, :drink_begin_at, :drink_end_at, :note, :position

      acts_as_indexed :fields => [:score, :note]

      validates :score, :presence => true, :uniqueness => true
    end
  end
end
