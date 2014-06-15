class AddRoleToRefineryMembers < ActiveRecord::Migration
  def change
    add_column :refinery_members, :role, :string
  end
end
