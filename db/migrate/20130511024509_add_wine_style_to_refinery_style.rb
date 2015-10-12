class AddWineStyleToRefineryStyle < ActiveRecord::Migration
  def change
    add_column :refinery_wines, :wine_style, :string
  end
end
