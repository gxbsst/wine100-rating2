class CreateWineGroupsWineGroupItems < ActiveRecord::Migration

  def up
    create_table :refinery_wine_groups_wine_group_items do |t|
      t.integer :wine_id
      t.integer :group_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-wine_groups"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/wine_groups/wine_group_items"})
    end

    drop_table :refinery_wine_groups_wine_group_items

  end

end
