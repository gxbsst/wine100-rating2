class AddAlcoholToRefineryWines < ActiveRecord::Migration
  def change
    add_column :refinery_wines, :alcohol, :string
  end
end
