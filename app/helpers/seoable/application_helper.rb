module Seoable
  module ApplicationHelper
    def seoable_title
      @seo_detail ? @seo_detail.meta_title : Seoable.configuration.default_title
    end

    def seoable_description
      if @seo_detail && @seo_detail.meta_description.present?
        @seo_detail.meta_description
      else
        Seoable.configuration.default_description
      end
    end
  end
end
