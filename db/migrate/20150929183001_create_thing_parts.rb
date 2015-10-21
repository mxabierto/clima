class CreateThingParts < ActiveRecord::Migration
  def change
    create_table :thing_parts do |t|
      t.string :name
      t.string :field1
      t.string :field2
      t.string :field3

      t.timestamps null: false
    end
  end
end
