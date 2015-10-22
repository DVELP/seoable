require 'spec_helper'

module Seoable
  describe ApplicationHelper, type: :helper do
    describe '#seoable_title' do
      let(:default_title) { Seoable.configuration.default_title }

      subject { helper.seoable_title }

      context 'with seo detail' do
        let(:seo_detail) { build(:seo_detail) }

        before(:each) do
          assign(:seo_detail, seo_detail)
        end

        it 'returns seo title' do
          expect(subject).to eq(seo_detail.meta_title)
        end
      end

      context 'without seo detail' do
        it 'returns default title' do
          expect(subject).to eq(default_title)
        end
      end
    end

    describe '#seoable_description' do
      let(:default_description) { Seoable.configuration.default_description }

      subject { helper.seoable_description }

      context 'with seo detail' do
        context 'with meta_description' do
          let(:seo_detail) { build(:seo_detail) }

          before(:each) do
            assign(:seo_detail, seo_detail)
          end

          it 'returns seo description' do
            expect(subject).to eq(seo_detail.meta_description)
          end
        end

        context 'without meta_description' do
          let(:seo_detail) { build(:seo_detail, meta_description: nil) }

          before(:each) do
            assign(:seo_detail, seo_detail)
          end

          it 'returns default description' do
            expect(subject).to eq(default_description)
          end
        end
      end

      context 'without seo detail' do
        it 'returns default description' do
          expect(subject).to eq(default_description)
        end
      end
    end
  end
end
