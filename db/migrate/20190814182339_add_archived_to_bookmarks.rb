class AddArchivedToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :archived, :boolean, default: false
  end
end
