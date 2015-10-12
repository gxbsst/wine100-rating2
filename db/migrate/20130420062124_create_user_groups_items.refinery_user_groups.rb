# This migration comes from refinery_user_groups (originally 2)
class CreateUserGroupsItems < ActiveRecord::Migration

  def up
    create_table :refinery_user_groups_items do |t|
      t.integer :refinery_member_id
      t.integer :refinery_user_group_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-user_groups"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/user_groups/items"})
    end

    drop_table :refinery_user_groups_items

  end

end
