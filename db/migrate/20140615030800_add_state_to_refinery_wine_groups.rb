class AddStateToRefineryWineGroups < ActiveRecord::Migration
  def change
    add_column :refinery_wine_groups, :state, :string
  end
end
