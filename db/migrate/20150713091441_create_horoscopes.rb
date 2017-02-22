class CreateHoroscopes < ActiveRecord::Migration
  def change
    create_table :horoscopes do |t|
      t.string   :sign,           limit: 50
      t.string   :duration,       limit: 50
      t.text     :horoscope_text
      t.date     :created_at
      t.date     :updated_at
    end
  end
end
