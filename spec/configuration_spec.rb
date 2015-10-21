require 'spec_helper'

describe Seoable::Configuration do
  after(:each) do
    Seoable.configuration = nil
    Seoable.configure {}
  end

  describe '#default_title' do
    context 'when no default_title is specified' do
      it 'defaults to application name' do
        expect(Seoable.configuration.default_title)
          .to eq(Rails.application.class.parent_name)
      end
    end

    context 'when a custom default_title is specified' do
      let(:title) { 'My title' }

      before(:each) do
        Seoable.configure do |config|
          config.default_title = title
        end
      end

      it 'is used instead of default' do
        expect(Seoable.configuration.default_title).to eq(title)
      end
    end
  end

  describe '#default_description' do
    context 'when no default_description is specified' do
      it 'defaults to application name' do
        expect(Seoable.configuration.default_description)
          .to eq(Rails.application.class.parent_name)
      end
    end

    context 'when a custom default_description is specified' do
      let(:description) { 'My description' }

      before(:each) do
        Seoable.configure do |config|
          config.default_description = description
        end
      end

      it 'is used instead of default' do
        expect(Seoable.configuration.default_description).to eq(description)
      end
    end
  end

  describe '#sluggable_attributes' do
    context 'when no sluggable_attributes are specified' do
      it 'defaults to full_name, name and title' do
        expect(Seoable.configuration.sluggable_attributes)
          .to eq([:full_name, :name, :title])
      end
    end

    context 'when a custom sluggable_attributes are specified' do
      let(:sluggable_attributes) { [:name, :surname, :intro] }

      before(:each) do
        Seoable.configure do |config|
          config.sluggable_attributes = sluggable_attributes
        end
      end

      it 'is used instead of default' do
        expect(Seoable.configuration.sluggable_attributes)
          .to eq(sluggable_attributes)
      end
    end
  end
end
