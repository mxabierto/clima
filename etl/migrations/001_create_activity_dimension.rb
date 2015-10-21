class CreateActivityDimension < ActiveRecord::Migration
  def change
    create_table :activity_dimension, :force => true do |t|
      t.string :trackable_type
      t.string :key
      t.string :created_at
    end
  end
end