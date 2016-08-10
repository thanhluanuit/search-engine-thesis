# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  user_name      :string(255)
#  full_name      :string(255)
#  description    :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class User < ActiveRecord::Base
  validates :user_name, :presence => true, :uniqueness => true

  has_and_belongs_to_many :documents
  has_and_belongs_to_many :annotations
end
