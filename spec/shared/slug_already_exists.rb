require 'spec_helper'

module Seoable
  shared_examples 'slug_already_exists' do
    before(:each) do
      create(:seo_detail,
             seoable_type: model_instance.class.name,
             slug: model_instance.title.to_slug)

      model_instance.save
    end

    it 'does not persist seoable' do
      expect(model_instance.persisted?).to be false
    end
  end
end
