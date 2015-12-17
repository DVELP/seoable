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
      it { is_expected.to have_many(:redirects).class_name('SeoDetailRedirect') }
    end

    context '.permitted_attribute_names' do
      it 'returns an array' do
        expect(SeoDetail.permitted_attribute_names).to be_a(Array)
      end
    end

    describe '.with_redirects' do
      context 'when redirect exists' do
        it 'returns the seo detail on the redirect' do
          seo_detail = create(:seo_detail, slug: 'robin', seoable_type: 'post')
          create(:seo_detail_redirects, seo_detail: seo_detail, old_slug: 'blake')
          expect(SeoDetail.with_redirects('post', 'blake').first).to eq seo_detail
        end

        it 'returns the directly the seo detail of the slug' do
          seo_detail = create(:seo_detail, slug: 'robin', seoable_type: 'post')
          create(:seo_detail_redirects, seo_detail: seo_detail, old_slug: 'blake')
          expect(SeoDetail.with_redirects('post', 'robin').first).to eq seo_detail
        end
      end

      context 'when redirect does not exists' do
        it 'returns the seo detail for the slug' do
          seo_detail = create(:seo_detail, slug: 'robin', seoable_type: 'post')
          expect(SeoDetail.with_redirects('post', 'robin').first).to eq seo_detail
        end
      end

      context 'when there is no seo details for the slug' do
        it 'returns nothing' do
          create(:seo_detail, slug: 'robin', seoable_type: 'post')
          expect(SeoDetail.with_redirects('post', 'blake')).to be_empty
        end
      end
    end

    context 'slug change' do
      it 'creates a new redirect record' do
        seo_detail = create(:seo_detail, slug: 'batman-belt')
        expect {
          seo_detail.update_attributes(slug: 'superman-cape')
        }.to change { seo_detail.redirects.count }
      end
    end

    context 'slug does not change' do
      it 'creates a new redirect record' do
        seo_detail = create(:seo_detail, slug: 'batman-belt')
        expect {
          seo_detail.update_attributes(meta_title: 'the dark night')
        }.not_to change { seo_detail.redirects.count }
      end
    end

  end
end
