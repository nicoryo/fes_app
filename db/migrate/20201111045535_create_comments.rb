class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.string :artist_id,null: false, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:user_id,:artist_id, :created_at]
  end
end
