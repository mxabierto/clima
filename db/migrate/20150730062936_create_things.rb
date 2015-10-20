class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.string :name
      t.integer :age
      t.float :price
      t.date :expires
      t.datetime :discharged_at
      t.text :description
      t.boolean :published
      t.string :gender

      t.timestamps null: false
    end
  end
end
