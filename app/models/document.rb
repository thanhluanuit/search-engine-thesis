# == Schema Information
#
# Table name: documents
#
#  id             :integer          not null, primary key
#  url            :string(255)
#  description    :text
#  content        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Document < ActiveRecord::Base
  include Searchable

  validates :url, :presence => true

  has_and_belongs_to_many :users
  has_and_belongs_to_many :annotations

  def from_date
    (Time.current.to_date - created_at.to_date).to_i
  end
end
