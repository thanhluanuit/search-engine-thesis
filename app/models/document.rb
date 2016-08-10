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
  validates :url, :presence => true
end
