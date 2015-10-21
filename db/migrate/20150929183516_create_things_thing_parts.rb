class CreateThingsThingParts < ActiveRecord::Migration
  def change
    create_table :things_thing_parts, id: false do |t|
      t.belongs_to :thing, index: true
      t.belongs_to :thing_part, index: true
    end
  end
end
