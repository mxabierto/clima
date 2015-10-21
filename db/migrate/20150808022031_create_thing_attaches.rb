class CreateThingAttaches < ActiveRecord::Migration
  def change
    create_table :thing_attaches do |t|
      t.string :file_id

      t.timestamps null: false
    end
  end
end
