module Seoable
  class SeoDetailRedirect < ActiveRecord::Base

    belongs_to :seo_detail, required: true

    validates :old_slug, presence: true
  end
end