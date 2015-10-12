# This migration comes from refinery_test_papers (originally 1)
class CreateTestPapersTestPapers < ActiveRecord::Migration

  def up
    create_table :refinery_test_papers do |t|
      t.integer :wine_id
      t.integer :user_id
      t.integer :group_id
      t.string :score
      t.datetime :drink_begin_at
      t.datetime :drink_end_at
      t.text :note
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-test_papers"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/test_papers/test_papers"})
    end

    drop_table :refinery_test_papers

  end

end
