class AddFinalScoreToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :final_score, :string
  end
end
