class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :sex, :string, null: false
    add_column :users, :birthday, :date, null: false
    add_column :users, :introduction, :text, nul:false
  end
end
