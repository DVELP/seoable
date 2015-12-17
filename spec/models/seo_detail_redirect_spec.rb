require 'spec_helper'

module Seoable
  describe SeoDetailRedirect, type: :model do
    context 'relations' do
      it{ is_expected.to belong_to(:seo_detail) }
    end

    context 'validations' do
      it{ is_expected.to validate_presence_of(:old_slug) }
      it{ is_expected.to validate_presence_of(:seo_detail) }
    end
  end
end