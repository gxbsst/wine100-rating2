# This migration comes from refinery_members (originally 1)
class CreateMembersMembers < ActiveRecord::Migration

  def up
    create_table :refinery_members do |t|
      t.string :name
      t.string :password_digest
      t.string :email
      t.string :password_cleartext
      t.integer :builder_id
      t.datetime :last_sign_in_at
      t.datetime :remember_created_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-members"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/members/members"})
    end

    drop_table :refinery_members

  end

end
