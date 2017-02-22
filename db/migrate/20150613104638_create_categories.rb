class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string   :name,   limit: 150
      t.string   :type,   limit: 150

      t.timestamps
    end

    add_index :categories, :name
    add_index :categories, :type
  end
end
