# == Schema Information
#
# Table name: annotations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Annotation < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
end
