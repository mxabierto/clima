class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :list_order

      t.timestamps null: false
    end
  end
end
