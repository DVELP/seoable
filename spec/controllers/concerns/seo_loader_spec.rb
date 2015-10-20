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
        seo_loader.params = {}
      end

      it 'loads seo details from loader' do
        expect(seo_detail_loader).to receive(:load)

        subject
      end
    end
  end
end
