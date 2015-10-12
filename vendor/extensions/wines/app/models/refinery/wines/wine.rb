module Refinery
  module Wines
    class Wine < Refinery::Core::BaseModel
      self.table_name = 'refinery_wines'

      attr_accessible :name_zh, :name_en, :region_en, :region_zh, :vingate, :sugar, :grape_vairety, :description, :position

      acts_as_indexed :fields => [:name_zh, :name_en, :region_en, :region_zh, :vingate, :sugar, :grape_vairety, :description]

      validates :name_zh, :presence => true, :uniqueness => true
    end
  end
end
