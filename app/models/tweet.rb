# == Schema Information
#
# Table name: tweets
#
#  id                           :integer          not null, primary key
#  uri                          :string(255)
#  text                         :text
#  expanded_url                 :string(255)
#  display_url                  :string(255)
#  url                          :string(255)
#  user_name                    :string(255)
#  lang                         :string(255)
#  geo                          :string(255)
#  source                       :string(255)
#  original_tweet_id            :bigint
#  tweet_created_at             :datetime
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
class Tweet < ActiveRecord::Base
  validates :original_tweet_id, :user_name, :uri, :presence => true
end
