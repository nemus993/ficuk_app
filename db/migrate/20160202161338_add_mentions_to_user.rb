class AddMentionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :mentions, :integer
  end
end
