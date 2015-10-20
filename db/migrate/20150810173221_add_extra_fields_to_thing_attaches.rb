class AddExtraFieldsToThingAttaches < ActiveRecord::Migration
  def change
    add_column :thing_attaches, :file_filename, :string
    add_column :thing_attaches, :file_size, :integer
    add_column :thing_attaches, :file_content_type, :string
  end
end
