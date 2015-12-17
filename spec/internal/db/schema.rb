ActiveRecord::Schema.define do
  create_table :seo_details do |t|
    t.string  :meta_title
    t.text    :meta_description
    t.string  :slug
    t.string  :seoable_type
    t.integer :seoable_id

    t.timestamps null: false
  end

  add_index :seo_details, :seoable_type
  add_index :seo_details, [:seoable_type, :seoable_id], unique: true
  add_index :seo_details, [:seoable_type, :slug], unique: true

  create_table :seoable_classes do |t|
    t.string :title

    t.timestamps null: false
  end

  create_table :seo_detail_redirects do |t|
    t.integer :seo_detail_id
    t.string :old_slug
  end

  add_index :seo_detail_redirects, :seo_detail_id
  add_foreign_key :seo_detail_redirects, :seo_details
end
