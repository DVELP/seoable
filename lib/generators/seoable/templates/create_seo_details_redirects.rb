class CreateSeoDetailsRedirects < ActiveRecord::Migration
  def change
    create_table :seo_detail_redirects do |t|
      t.integer :seo_detail_id
      t.string :old_slug
    end

    add_index :seo_detail_redirects, :seo_detail_id
    add_foreign_key :seo_detail_redirects, :seo_details
  end
end
