require 'spec_helper'
require 'shared/slug_already_exists'

module Seoable
  shared_examples 'acts_as_seoable' do
    include Shoulda::Matchers::ActiveRecord

    let(:class_sym) { described_class.to_s.underscore.to_sym }
    let(:model_instance) { build(class_sym) }

    context 'relations' do
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

        context 'parent model is invalid' do
          it 'keeps associated seo detail intact' do
            model_instance.save
            old_seo_detail_id = model_instance.seo_detail.id

            expect(model_instance).to receive(:valid?).and_return false

            new_seo_detail = build(:seo_detail)
            model_instance.update_attributes({meta_title: new_seo_detail.meta_title})

            expect(SeoDetail.where(id: old_seo_detail_id).first).to be_present
          end
        end
      end
    end

    context 'destroy' do
      it 'destroys associated seo_detail' do
        model_instance.save

        expect { model_instance.destroy }.to change(SeoDetail, :count).by(-1)
      end
    end
  end
end
