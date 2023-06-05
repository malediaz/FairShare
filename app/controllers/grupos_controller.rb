class GruposController < ApplicationController
    before_action :set_grupo, only: [:show, :edit, :update, :destroy]

    def index
        @grupos = Grupo.all
    end

    def new
        @grupo = Grupo.new
        @usuarios = Usuario.all
    end
    
    def create
        @grupo = Grupo.new(grupo_params)
        if @grupo.save
            usuario_agregar
            redirect_to @grupo, notice: 'Grupo creado exitosamente.'
        else
        render :new
        end
    end
    
    def show
        @usuarios_grupo = @grupo.usuarios
    end

    def edit
        @usuarios = Usuario.all
        @usuarios_grupo = @grupo.usuarios
    end

    def update
        if @grupo.update(grupo_params)
            flash[:notice] = 'Grupo actualizado exitosamente.'
            redirect_to @grupo
        else
            flash[:alert] = 'El grupo no pudo actualizarse.'
            render :edit
        end
    end

    
    
    def usuario_agregar
        usuario_ids = params[:grupo][:id_usuarios] || [] # Obtener los IDs de los usuarios seleccionados desde el formulario
        
        usuario_ids.each do |usuario_id|
            @grupo.grupos_usuarios.create(usuario_id: usuario_id, grupo_id: @grupo.id) unless @grupo.grupos_usuarios.exists?(usuario_id: usuario_id, grupo_id: @grupo.id)
        end
        
        #flash[:notice] = 'Usuarios agregados al grupo exitosamente.'
        #redirect_to grupo_path(@grupo)
    end
    
    def destroy
        if @grupo.destroy
            flash[:notice] = 'Grupo eliminado exitosamente.'
            redirect_to grupos_path
        else
            flash[:alert] = 'El grupo no pudo actualizarse.'
            redirect_to  @grupo
        end
    end
    
    private

    def set_grupo
        @grupo = Grupo.find(params[:id])
    end
    
    def grupo_params
        params.require(:grupo).permit(:nombre, :descripcion, usuario_ids: [])
    end
end
