module Refinery
  module Wines
    class Wine < Refinery::Core::BaseModel
      self.table_name = 'refinery_wines'

      attr_accessible :name_zh, :name_en, :region_en, :region_zh, :vingate, :sugar, :grape_vairety, :description, :position, :uuid, :wine_style, :alcohol

      acts_as_indexed :fields => [:name_zh, :name_en, :region_en, :region_zh, :vingate, :sugar, :grape_vairety, :description]

      #validates  :presence => true, :uniqueness => true

      has_one :award, :class_name => '::Award', :foreign_key => 'wine_id'

      def award_value
        return 0 unless self.award
        self.award.award.to_i
      end

      def final_award_value
        return 0 unless self.award
        self.award.final.to_i
      end

      def final_score
        return 'None' unless self.award
        self.award.final_score
      end

      def final_final_score
        return 'None' unless self.award
        self.award.final_final_score
      end

      def name
        "#{vingate} #{name_en}  #{vingate} #{name_zh}"
      end

    end
  end
end
