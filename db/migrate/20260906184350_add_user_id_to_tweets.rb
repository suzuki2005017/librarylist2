class AddUserIdToTweets < ActiveRecord::Migration[7.2]
  def change
    # null: true を明示的に指定して空（NULL）を許可します
    add_reference :tweets, :user, null: true, foreign_key: true
  end
end