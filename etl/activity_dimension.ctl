pre_process do
  migrations_folder = File.expand_path(File.dirname(__FILE__) + '/migrations')
  version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
  ActiveRecord::Base.establish_connection(:warehouse)
  ActiveRecord::Migrator.migrate(migrations_folder, version)
end


source :in, {type: :database, target: :operational, table: "activities"}, [:trackable_type, :key, :created_at]

destination :out,
            {type: :insert_update_database, target: :warehouse, table: 'activity_dimension'},
            {primarykey: [:id], order: [:trackable_type, :key, :created_at]}
