class ChangeDrinkBeginAtAndEndAtType < ActiveRecord::Migration
  def up
    change_column :refinery_test_papers, :drink_begin_at, :string
    change_column :refinery_test_papers, :drink_end_at, :string
  end

  def down
    change_column :refinery_test_papers, :drink_begin_at, :datetime
    change_column :refinery_test_papers, :drink_end_at, :datetime
  end
end
