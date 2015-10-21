module Seoable
  FactoryGirl.define do
    factory :seo_detail, class: SeoDetail do
      sequence(:meta_title) { |n| "Page title #{n}" }
      sequence(:slug) { |n| "slug-#{n}" }
      meta_description 'page description'
      seoable_type 'Object'
      sequence(:seoable_id) { |n| n }
    end
  end
end
