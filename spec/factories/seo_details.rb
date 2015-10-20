module Seoable
  FactoryGirl.define do
    factory :seo_detail, class: SeoDetail do
      meta_title 'Page title'
      slug 'meta-title'
      meta_description 'page description'
      seoable_type 'Object'
      seoable_id 1
    end
  end
end
