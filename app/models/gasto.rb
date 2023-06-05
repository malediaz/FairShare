class Gasto < ApplicationRecord 
    belongs_to :usuario
    has_many :divisions
    #t.decimal :monto
  end 
