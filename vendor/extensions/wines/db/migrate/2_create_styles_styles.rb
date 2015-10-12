class CreateStylesStyles < ActiveRecord::Migration

  def up
    create_table :refinery_styles do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-styles"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/styles/styles"})
    end

    drop_table :refinery_styles

  end

end
