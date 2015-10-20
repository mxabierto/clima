class AddFieldsToThingContacts < ActiveRecord::Migration
  def change
    add_column :thing_contacts, :field1, :string
    add_column :thing_contacts, :field2, :string
    add_column :thing_contacts, :field3, :string
  end
end
