module Seoable
  class SeoDetail < ActiveRecord::Base
    cattr_accessor :permitted_attribute_names
    @@permitted_attribute_names = [:meta_title, :meta_description, :slug]

    belongs_to :seoable, polymorphic: true

    validates :meta_title, presence: true, uniqueness: { scope: :seoable_type }
    validates :slug,
              uniqueness: { scope: :seoable_type },
              format: /\A[a-z0-9-]+\z/
  end
end
