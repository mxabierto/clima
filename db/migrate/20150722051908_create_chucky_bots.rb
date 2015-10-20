class CreateChuckyBots < ActiveRecord::Migration
  def change
    create_table :chucky_bots do |t|
      t.string :underscore_model_name
      t.string :i18n_singular_name
      t.string :i18n_plural_name
      t.text :authorization
      t.text :public_activity
      t.boolean :migrate
      t.text :fields
      t.text :chucky_command

      t.timestamps null: false
    end
  end
end
