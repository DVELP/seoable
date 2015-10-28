require 'spec_helper'
require 'shared/slug_already_exists'

module Seoable
  shared_examples 'acts_as_seoable' do
    include Shoulda::Matchers::ActiveRecord

    let(:class_sym) { described_class.to_s.underscore.to_sym }
    let(:model_instance) { build(class_sym) }

    context 'validations' do
      it { is_expected.to accept_nested_attributes_for(:seo_detail) }
    end

    context 'relations' do
      it do
        is_expected.to have_one(:seo_detail)
          .dependent(:destroy)
          .class_name('SeoDetail')
      end
      it { is_expected.to delegate_method(:meta_title).to(:seo_detail) }
      it { is_expected.to delegate_method(:meta_description).to(:seo_detail) }
      it { is_expected.to delegate_method(:slug).to(:seo_detail) }
    end

    context 'acts as seoable' do
      it { expect(described_class).to respond_to(:acts_as_seoable) }
    end

    context 'new model create' do
      context 'slug already exists' do
        it_behaves_like 'slug_already_exists'
      end

      context 'seo detail valid' do
        it 'creates seo detail' do
          expect{model_instance.save}.to change(SeoDetail, :count).by(1)
        end

        it 'assigns correct meta_title to seo detail' do
          model_instance.save
          expect(model_instance.seo_detail.meta_title)
            .to eq(model_instance.title)
        end

        it 'assigns correct slug to seo detail' do
          model_instance.save
          expect(model_instance.seo_detail.slug)
            .to eq(model_instance.title.to_slug)
        end
      end
    end

    context 'update model' do
      context 'without seo detail' do
        it 'creates seo detail' do
          expect{model_instance.save}.to change(SeoDetail, :count).by(1)
        end
      end

      context 'with seo detail' do
        context 'slug already exists' do
          it_behaves_like 'slug_already_exists'
        end

        context 'seo detail valid' do
          it 'updates slug' do
            title = 'New title'
            slug = title.to_slug
            model_instance.title = title
            model_instance.save

            expect(model_instance.slug).to eq(slug)
          end
        end
      end
    end
  end
end
