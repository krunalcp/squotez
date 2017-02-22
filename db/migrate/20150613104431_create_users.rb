class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :first_name,   limit: 100
      t.string   :last_name,    limit: 100
      t.string   :birth_date,   limit: 30
      t.string   :birth_sign,   limit: 30
      t.string   :gender,       limit: 1
      t.string   :email,        limit: 255
      t.string   :contact_no,   limit: 20

      t.timestamps
    end

    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :gender
    add_index :users, :email
    add_index :users, :contact_no
  end
end
