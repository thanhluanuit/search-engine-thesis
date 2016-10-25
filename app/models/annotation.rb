# == Schema Information
#
# Table name: annotations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  related_tags :array            default []
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Annotation < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_and_belongs_to_many :documents
  has_and_belongs_to_many :users
end
