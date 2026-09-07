class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :name
      t.string :place
      t.string :access
      t.string :net
      t.string :outlet
      t.time :time
      t.string :photo
      t.text :recommend

      t.timestamps
    end
  end
end
