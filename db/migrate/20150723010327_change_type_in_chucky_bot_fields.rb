class ChangeTypeInChuckyBotFields < ActiveRecord::Migration
  def change
    rename_column :chucky_bot_fields, :type, :field_type
  end
end
