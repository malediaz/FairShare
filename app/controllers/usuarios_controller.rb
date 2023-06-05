class UsuariosController < ApplicationController
  # Se utiliza el callback before_action para configurar el método set_usuario, el cual se ejecuta antes 
  # de las acciones show, edit, update y destroy para buscar y configurar el objeto @usuario correspondiente
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

  def index
    @usuarios = Usuario.all
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      flash[:notice] = 'Creación de usuario exitosa.'
      redirect_to @usuario
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @usuario.update(usuario_params)
      flash[:notice] = 'Modificación de usuario exitosa.'
      redirect_to @usuario
    else
      render :edit
    end
  end

  def destroy
    @usuario.destroy
    redirect_to usuarios_url, notice: 'Usuario eliminado exitosamente.'
  end

  private

  def set_usuario
    @usuario = Usuario.find(params[:id])
  end

  def usuario_params
    params.require(:usuario).permit(:nombre, :email, :contraseña, :confir)
  end
end
