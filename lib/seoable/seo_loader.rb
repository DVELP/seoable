module Seoable
  module SeoLoader
    extend ActiveSupport::Concern

    included do
      prepend_before_action :load_seo_detail, only: [:index, :show]
    end

    def load_seo_detail
      seo_detail_loader = Loader.new(controller_name, params[:id])
      @seo_detail = seo_detail_loader.load

      redirect_to request.path.gsub(params[:id], @seo_detail.slug) if @seo_detail.slug != params[:id]
    end
  end
end
