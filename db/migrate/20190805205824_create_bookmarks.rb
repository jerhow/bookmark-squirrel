class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.text :url
      t.text :desc

      t.timestamps
    end
  end
end
