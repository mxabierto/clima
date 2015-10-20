class AddIconToChuckyBots < ActiveRecord::Migration
  def change
    add_column :chucky_bots, :icon, :string
  end
end
