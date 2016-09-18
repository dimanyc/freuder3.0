class CreateListenerTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :listener_tweets do |t|
      t.integer  :listener_id
      t.integer  :tweet_id
      t.jsonb    :slips, default: {
        hashtag_slips: [],
        mention_slips: [],
        keyword_slips: []
      }
      t.index   :slips, using: :gin
      t.index   [:listener_id, :tweet_id]
      t.index   [:listener_id, :slips]
      t.timestamps
    end
  end
end
