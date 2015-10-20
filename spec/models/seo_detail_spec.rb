require 'spec_helper'

module Seoable
  describe SeoDetail, type: :model do
    let(:seo_detail) { build(:seo_detail) }

    context 'validations' do
      it { is_expected.to validate_presence_of(:meta_title) }
      it { is_expected.to validate_uniqueness_of(:meta_title).scoped_to(:seoable_type) }
      it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:seoable_type) }
      it { is_expected.to allow_value('valid-slug').for(:slug) }
      it { is_expected.to_not allow_value('Invalid slug').for(:slug) }
    end

    context 'relations' do
      it { is_expected.to belong_to(:seoable) }
    end

    context '.permitted_attribute_names' do
      it 'returns an array' do
        expect(SeoDetail.permitted_attribute_names).to be_a(Array)
      end
    end
  end
end
