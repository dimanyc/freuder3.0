class CreateListeners < ActiveRecord::Migration[5.0]
  def change
    create_table  :listeners do |t|
      t.string    :name
      t.jsonb     :search_terms, default: {
        keywords:     [],
        key_mentions: [],
        key_hashtags: []
      }
      t.jsonb     :options, default: {
        case_sensitive:           true,
        mentions:                 false,
        hashtags:                 false,
        use_keywords_everywhere:  false,
        include_replies:          true
      }
      t.timestamps
      t.index     :search_terms, using: :gin
    end
  end
end
