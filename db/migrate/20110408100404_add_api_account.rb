class AddApiAccount < ActiveRecord::Migration
  def self.up
    create_table :api_accounts do |t|
      t.string :key
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :api_accounts
  end
end
