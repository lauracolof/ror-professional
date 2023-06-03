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
  scope :latest, -> (limit) { order("id desc").limit(limit)}
  # Ex:- scope :active, -> {where(:active => true)}

  #método de clase => self.
  def self.paginate (page=1, per_page=15)
    #limite de registros por página per_page
    Photo.order("id desc").offset(page * per_page).limit(per_page)
    # quiero todos los registros de fotos con un limite de 15, primero mostramos los ultimos. Offset(10), apartir del 11 y máximo 15
  end
end
