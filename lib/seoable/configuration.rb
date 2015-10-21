module Seoable
  class Configuration
    attr_accessor :default_title, :default_description, :sluggable_attributes

    def initialize
      @default_title = Rails.application.class.parent_name
      @default_description = @default_title
      @sluggable_attributes = [:full_name, :name, :title]
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
