class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :uri
      t.text :text
      t.string :expanded_url
      t.string :display_url
      t.string :url
      t.string :user_name
      t.string :lang
      t.string :geo
      t.string :source
      t.bigint :original_tweet_id
      t.datetime :tweet_created_at

      t.timestamps null: false
    end
  end
end
