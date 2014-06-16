class AddFinalFinalScoreToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :final_final_score, :string
  end
end
