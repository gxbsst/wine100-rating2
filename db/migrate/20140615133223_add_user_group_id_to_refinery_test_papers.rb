class AddUserGroupIdToRefineryTestPapers < ActiveRecord::Migration
  def change
    add_column :refinery_test_papers, :user_group_id, :integer
  end
end
