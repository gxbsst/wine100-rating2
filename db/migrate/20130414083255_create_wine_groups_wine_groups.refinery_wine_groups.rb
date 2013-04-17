# This migration comes from refinery_wine_groups (originally 1)
class CreateWineGroupsWineGroups < ActiveRecord::Migration

  def up
    create_table :refinery_wine_groups do |t|
      t.string :name
      t.integer :judge_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-wine_groups"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/wine_groups/wine_groups"})
    end

    drop_table :refinery_wine_groups

  end

end
