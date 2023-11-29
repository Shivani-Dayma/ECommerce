namespace :schema do
    desc 'Delete a specific table'
    task delete: :environment do
      table_name = 'carts'
      
      # Disable foreign key constraints
      ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF")
  
      # Drop the table
      ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS #{table_name}")
      puts "Table #{table_name} deleted"
  
      # Re-enable foreign key constraints
      ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON")
    end
  end
  