require 'rails/generators/active_record'

module Seoable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ::Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      desc 'Installs Seoable and generates the necessary migrations'

      def create_migrations
        migration_template 'create_seo_details.rb',
                           'db/migrate/create_seo_details.rb'
      end

      def create_initializer
        copy_file 'initializers/seoable.rb', 'config/initializers/seoable.rb'
      end

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end
    end
  end
end
