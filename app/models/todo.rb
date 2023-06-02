class Todo < ApplicationRecord 
  # aqui van las validaciones
  validates :title, uniqueness: true, presence: true
  # para que nose repita el titulo
  # que no pueda estar vacio
  # vacío para ruby tmb es nil y blank
end