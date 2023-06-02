# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  image_url  :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Photo < ApplicationRecord
  validates :title, presence: true
  #para validar campo con regEx, al principio lo que sea cualquiera, pero que termine con...
  # validates_format_if :image_url, with: /.\.(png|jpeg|jpg|gig)/
  # tdd: refactor dos validaciones en una sola linea
  validates :image_url, presence: true, format: { with: /.\.(png|jpeg|jpg|gig)/}

end
