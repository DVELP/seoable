require 'rails/engine'
require 'seoable/seo_loader'

module Seoable
  class Engine < ::Rails::Engine
    initializer 'seoable.action_controller' do
      ActiveSupport.on_load(:action_controller) do
        include SeoLoader
      end
    end
  end
end
