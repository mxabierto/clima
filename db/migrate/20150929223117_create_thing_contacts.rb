class CreateThingContacts < ActiveRecord::Migration
  def change
    create_table :thing_contacts do |t|
      t.string :name
      t.integer :thing_id

      t.timestamps null: false
    end
  end
end
