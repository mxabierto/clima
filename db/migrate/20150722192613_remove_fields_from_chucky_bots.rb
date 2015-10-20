class RemoveFieldsFromChuckyBots < ActiveRecord::Migration
  def change
    remove_column :chucky_bots, :fields, :text
  end
end
