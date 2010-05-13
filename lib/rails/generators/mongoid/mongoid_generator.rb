require 'rails/generators/migration'
# require 'mongoid/rails/generators/mongoid/mongoid_generator'

module Mongoid #:nodoc:
  module Generators #:nodoc:
    class Base < ::Rails::Generators::NamedBase #:nodoc:
    include Rails::Generators::Migration

    def self.source_root
      @_mongoid_source_root ||=
      File.expand_path("../../#{base_name}/#{generator_name}/templates", __FILE__)
    end
      
      # Implement the required interface for Rails::Generators::Migration.
      def self.next_migration_number(dirname) #:nodoc:
        next_migration_number = current_migration_number(dirname) + 1
        if Mongoid.timestamped_migrations
          [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_migration_number].max
        else
          "%.3d" % next_migration_number
        end
      end
    end
	end
end