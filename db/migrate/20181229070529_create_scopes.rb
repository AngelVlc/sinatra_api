class CreateScopes < ActiveRecord::Migration[5.2]
  def up
    add_timestamps :users, null: false

    create_table :scopes do |t|
      t.string :name
      t.timestamps
    end

    create_table :permissions, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :scope, index: false
    end
  end

  def down
    remove_column :users, :created_at
    remove_column :users, :updated_at
    drop_table :scopes
    drop_table :permissions
  end
end
