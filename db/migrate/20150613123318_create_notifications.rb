class CreateNotifications < ActiveRecord::Migration
  def change
     create_table :notifications do |t|
      t.text     :notification_text
      t.string   :type,        limit: 100
      t.string   :language,    limit: 50
      t.string   :author,      limit: 150

      t.timestamps
    end

    add_index :notifications, :type
    add_index :notifications, :language
  end
end
