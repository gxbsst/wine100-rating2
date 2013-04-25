class AddUuidToRefineryWine < ActiveRecord::Migration
  def change
    add_column :refinery_wines, :uuid, :string
    add_index :refinery, :uuid
  end
end
