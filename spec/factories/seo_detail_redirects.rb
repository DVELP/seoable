module Seoable
  FactoryGirl.define do
    factory :seo_detail_redirects, class: SeoDetailRedirect do
      old_slug "upage-#{SecureRandom.hex(10)}"
      seo_detail
    end
  end
end
