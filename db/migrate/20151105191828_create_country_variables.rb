class CreateCountryVariables < ActiveRecord::Migration
  def change
    create_table :country_variables do |t|
      t.string :variable
      t.string :country_name
      t.string :country_code
      t.integer :year
      t.float :value

      t.timestamps null: false
    end
  end
end
