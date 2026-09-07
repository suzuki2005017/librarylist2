class ChangeTimeToBeStringInTweets < ActiveRecord::Migration[7.0]
  def change
    change_column :tweets, :time, :string
  end
end