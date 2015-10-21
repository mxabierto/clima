class AddOnlyApiAccessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :only_api_access, :boolean
  end
end
