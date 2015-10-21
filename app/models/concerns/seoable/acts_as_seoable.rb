module Seoable
  module ActsAsSeoable
    extend ActiveSupport::Concern

    included do
      cattr_accessor :acts_as_seoable

      extend FriendlyId
      friendly_id :slug, use: :finders

      default_scope { joins_seo_detail }
      scope :joins_seo_detail, -> { includes(:seo_detail) }

      has_one :seo_detail,
              as: :seoable,
              dependent: :destroy,
              class_name: SeoDetail

      accepts_nested_attributes_for :seo_detail

      delegate :meta_title, to: :seo_detail, allow_nil: true
      delegate :meta_description, to: :seo_detail, allow_nil: true
      delegate :slug, to: :seo_detail, allow_nil: true

      before_validation :build_seo_detail
    end

    private

      def build_seo_detail
        if seo_detail.blank?
          super(seo_detail_attributes)
        else
          seo_detail.assign_attributes(seo_detail_attributes)
        end
      end

      def seo_detail_attributes
        {
          meta_title: sluggable,
          seoable: self,
          slug: sluggable.to_slug
        }
      end

      def sluggable
        attribute = Seoable.configuration
                    .sluggable_attributes.find do |sluggable_attribute|
                      self.respond_to?(sluggable_attribute)
                    end

        if attribute.present?
          send(attribute)
        else
          Seoable.configuration.sluggable_attributes.first.to_s
        end
      end
  end
end

module FriendlyId
  module FinderMethods
    def first_by_friendly_id(id)
      find_by('"seo_details".' + friendly_id_config.query_field => id)
    end
  end
end

class String
  def to_slug
    parameterize
  end
end
