module Seoable
  class Loader
    def initialize(controller_name, slug)
      @model_name = controller_name.classify
      @slug = slug
    end

    def load
      return nil unless seoable_model?

      SeoDetail.where(seoable_type: model, slug: @slug).first
    end

    private

      def model
        model = @model_name.constantize
        model = model.superclass if model.superclass != ActiveRecord::Base
        model
      end

      def seoable_model?
        return false unless Object.const_defined?(@model_name)
        const = Object.const_get(@model_name)
        const.respond_to?(:acts_as_seoable)
      end
  end
end
