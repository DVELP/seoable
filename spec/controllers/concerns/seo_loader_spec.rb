require 'spec_helper'

module Seoable
  class FakeController < ActionController::Base
    include SeoLoader

    attr_accessor :params
  end

  describe SeoLoader do
    describe '#load_seo_detail' do
      let(:seo_detail_loader) { double('seo_detail_loader') }
      let(:seo_loader) { FakeController.new }

      subject { seo_loader.load_seo_detail }

      before(:each) do
        allow(FakeController).to receive(:prepend_before_action)
        allow(Loader).to receive(:new).and_return(seo_detail_loader)
        seo_loader.params = {id: 'batman'}
      end

      it 'loads seo details from loader' do
        allow(seo_detail_loader).to receive(:load).and_return(create(:seo_detail, slug: 'batman'))
        subject
      end

      context 'returned slug is different' do
        before(:each) do
          allow(FakeController).to receive(:prepend_before_action)
          loader = double('loader')
          allow(Loader).to receive(:new).and_return(loader)
          allow(loader).to receive(:load).and_return(create(:seo_detail, slug: 'clark'))
          seo_loader.params = {id: 'superman'}
        end

        it 'redirects to the new one' do
          allow_any_instance_of(FakeController).to receive(:request).and_return(double('request', path: 'bio/superman/full'))
          expect_any_instance_of(FakeController).to receive(:redirect_to).with('bio/clark/full')
          seo_loader.load_seo_detail
        end
      end
    end
  end
end
