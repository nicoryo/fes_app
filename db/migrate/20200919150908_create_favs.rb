class CreateFavs < ActiveRecord::Migration[6.0]
  def change
    create_table :favs do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :level

      t.timestamps
    end
  end
end
