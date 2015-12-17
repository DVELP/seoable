module Seoable
  class SeoDetail < ActiveRecord::Base
    cattr_accessor :permitted_attribute_names
    @@permitted_attribute_names = [:meta_title, :meta_description, :slug]

    belongs_to :seoable, polymorphic: true
    has_many :redirects, class_name: 'SeoDetailRedirect'

    after_update :create_redirect_if_needed

    validates :meta_title, presence: true, uniqueness: { scope: :seoable_type }
    validates :slug,
              uniqueness: { scope: :seoable_type },
              format: /\A[a-z0-9-]+\z/

    scope :with_redirects, -> (model, slug){ includes(:redirects).where('seoable_type = ? AND (seo_detail_redirects.old_slug = ? OR slug = ?)', model, slug, slug).references(:redirects) }

    private

    def create_redirect_if_needed
      self.redirects.create(old_slug: self.slug) if self.slug_changed?
    end
  end
end
