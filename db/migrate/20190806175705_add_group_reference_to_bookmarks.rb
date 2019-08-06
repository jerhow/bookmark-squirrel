class AddGroupReferenceToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookmarks, :group, foreign_key: true
  end
end
