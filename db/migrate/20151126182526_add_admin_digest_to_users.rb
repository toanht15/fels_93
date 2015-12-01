class AddAdminDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_digest, :boolean, default: false
  end
end
