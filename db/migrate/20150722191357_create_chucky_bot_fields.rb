class CreateChuckyBotFields < ActiveRecord::Migration
  def change
    create_table :chucky_bot_fields do |t|
      t.string :name
      t.string :type
      t.string :i18n_name
      t.text :formats_options
      t.text :validations_options
      t.text :association_options
      t.integer :chucky_bot_id

      t.timestamps null: false
    end
  end
end
