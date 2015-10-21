require 'spec_helper'
require 'friendly_id'
require 'shared/acts_as_seoable'

module Seoable
  class SeoableClass < ActiveRecord::Base
    include Seoable::ActsAsSeoable
  end

  FactoryGirl.define do
    factory 'seoable/seoable_class' do
      sequence(:title) { |n| "My title #{n}" }
    end
  end

  describe SeoableClass, type: :model do
    it_behaves_like 'acts_as_seoable'
  end
end
