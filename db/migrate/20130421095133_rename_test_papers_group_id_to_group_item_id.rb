class RenameTestPapersGroupIdToGroupItemId < ActiveRecord::Migration
  def up
    add_column :refinery_test_papers, :group_item_id, :integer
  end

  def down
    remove_column :refinery_test_papers, :group_item_id
  end
end
