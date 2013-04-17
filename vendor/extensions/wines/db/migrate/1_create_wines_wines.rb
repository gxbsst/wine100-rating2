class CreateWinesWines < ActiveRecord::Migration

  def up
    create_table :refinery_wines do |t|
      t.string :name_zh
      t.string :name_en
      t.string :region_en
      t.string :region_zh
      t.string :vingate
      t.string :sugar
      t.string :grape_vairety
      t.text :description
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-wines"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/wines/wines"})
    end

    drop_table :refinery_wines

  end

end
