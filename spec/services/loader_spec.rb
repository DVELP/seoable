require 'spec_helper'

module Seoable
  describe Loader do
    describe '#load' do
      let(:slug) { 'my-title' }
      let(:loader) { Loader.new('posts_controller', slug) }

      subject { loader.load }

      context 'non seoable model' do
        before(:each) do
          allow(loader).to receive(:seoable_model?).and_return(false)
        end

        it 'returns nil' do
          expect(subject).to be_nil

          subject
        end
      end

      context 'seoable model' do
        let(:model) { double('model') }

        before(:each) do
          allow(loader).to receive(:seoable_model?).and_return(true)
          allow(loader).to receive(:model).and_return(model)
        end

        it 'queries for seo detail' do
          expect(SeoDetail).to receive(:where)
            .with(seoable_type: model, slug: slug)
            .and_return([])

          subject
        end
      end
    end
  end
end
