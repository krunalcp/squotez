class CreateOtherDetails < ActiveRecord::Migration
  def change
    create_table :other_details do |t|
      t.integer  :detailable_id
      t.string   :detailable_type, limit: 50
      t.string   :detail_type,     limit: 150
      t.string   :detail,          limit: 1000
      t.date     :created_at
      t.date     :updated_at
    end
    add_index :other_details, :detailable_id
    add_index :other_details, :detailable_type
  end
end
