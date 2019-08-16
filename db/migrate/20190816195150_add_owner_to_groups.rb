class AddOwnerToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :owner_user_id, :bigint
  end
end
