class CreateSlips < ActiveRecord::Migration[5.0]
  def change
    create_table :slips do |t|
      t.string  :name
      t.jsonb   :slips, default: {
        keywords: [],
        mentions: [],
        hashtags: []
      }
      t.integer :listener_id
      t.integer :tweet_id
      t.string  :author
      t.string  :body
      t.timestamps
    end
  end
end
