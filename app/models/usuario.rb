class Usuario < ApplicationRecord
    has_many :gastos   
    has_many :splits, through: :gastos 
    has_many :grupos_usuarios, dependent: :destroy
    has_many :grupos, through: :grupos_usuarios

    validates_confirmation_of :contraseña
    validates_confirmation_of :nombre

  end 
