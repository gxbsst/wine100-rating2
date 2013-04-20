# This migration comes from refinery_user_groups (originally 1)
class CreateUserGroupsUserGroups < ActiveRecord::Migration

  def up
    create_table :refinery_user_groups do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-user_groups"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/user_groups/user_groups"})
    end

    drop_table :refinery_user_groups

  end

end
