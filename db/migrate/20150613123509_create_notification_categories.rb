class CreateNotificationCategories < ActiveRecord::Migration
  def change
    create_table :notification_categories do |t|
      t.integer  :notification_id
      t.integer  :category_id

      t.timestamps
    end

    add_index :notification_categories, :notification_id
    add_index :notification_categories, :category_id
  end
end
