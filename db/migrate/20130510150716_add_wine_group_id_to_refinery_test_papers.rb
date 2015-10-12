class AddWineGroupIdToRefineryTestPapers < ActiveRecord::Migration
  def change
    add_column :refinery_test_papers, :wine_group_id, :integer
    add_index :refinery_test_papers, :wine_group_id
  end
end
