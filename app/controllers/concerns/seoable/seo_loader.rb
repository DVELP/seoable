module Seoable
  module SeoLoader
    extend ActiveSupport::Concern

    included do
      prepend_before_action :load_seo_detail, only: [:index, :show]
    end

    def load_seo_detail
      seo_detail_loader = Loader.new(controller_name, params[:id])
      @seo_detail = seo_detail_loader.load
    end
  end
end
