class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :author
      t.string :body
      t.text   :mentions, array: true, default: []
      t.text   :hashtags, array: true, default: []
      t.timestamps
    end
  end
end
