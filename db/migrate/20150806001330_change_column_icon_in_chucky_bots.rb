class ChangeColumnIconInChuckyBots < ActiveRecord::Migration
  def change
    rename_column :chucky_bots, :icon, :fa_icon
  end
end
