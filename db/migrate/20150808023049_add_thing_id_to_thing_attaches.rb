class AddThingIdToThingAttaches < ActiveRecord::Migration
  def change
    add_column :thing_attaches, :thing_id, :integer
  end
end
