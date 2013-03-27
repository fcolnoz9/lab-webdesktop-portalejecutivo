class MenuAdminController < ApplicationController
  def index
    if(session[:nombre]==nil)
      redirect_to '/inicio'
    elsif(session[:rols_id]==1)
      redirect_to '/cli_comprador'
    elsif(session[:rols_id]==2)
      redirect_to '/concesionario'
    elsif(session[:rols_id]==3)
      redirect_to '/menu_ensambladora'
    end
  end

  def generar_menu
    @tipo=params[:tipo]
    @arbols = Arbols.new
    @tira = @arbols.BuscarTodosArbolJson(@tipo)
    render :text => @tira
  end

  def grabar_marca
    @marca= Marca.new
    @nombre=params[:nombre]
    @imagen=params[:imagen]
    @mision=params[:mision]
    @vision=params[:vision]
    @valores=params[:valores]
    @contacto=params[:contacto]
    @marca.grabar_marca(@nombre,@imagen,@mision,@vision,@valores,@contacto)
    render :text => $tirajson
  end

  def buscar_marca
    @marca = Marca.new
    nombre = params[:nombre]
    valor = @marca.buscar(nombre)
    render :text => $tirajson
  end

  def generardatacombosestados
    @estados = Estados.all
    @tirajson = @estados.to_json
    render :text => @tirajson
  end

  def generardatacombosciudades
    @ciudads = Ciudads.all
    $tirajson = @ciudads.to_json
    render :text => $tirajson
  end
  
  def generardatacombostipos
    @tipos = Tipo_Vehiculos.all
    $tirajson = @tipos.to_json
    render :text => $tirajson
  end
  
  def generardatacombosmodelos
    @modelos = Modelo_Vehiculo.all
    $tirajson = @modelos.to_json
    render :text => $tirajson
  end
  
  def generardatacomboscaracteristicas
    @caracteristicas = Caracteristicas.all
    $tirajson = @caracteristicas.to_json
    render :text => $tirajson
  end
  
  def generarcomboMarcas
    @marca = Marca.all
    $tira = @marca.to_json
    render :text => $tira
  end

  def generardatalistamarcas
    @marca = Marca.new
    $tirajson=@marca.generardatalistamarcas()
    render :text => $tirajson
  end

  def generardatalistaConcesionarios
    @concesionario = Concesionario_vehiculos.new
    $tirajson=@concesionario.generardatalistaConcesionarios()
    render :text => $tirajson
  end

  #Adriana Santana -->Sino quieren ver una trigra con tigritos recien nacidos por favor no borren esto
  def grabar_concesionario
    puts 'AQUI'
    @concesionario = Concesionario_vehiculos.new
    @usuario = Usuario.new
    @rif=params[:rif]
    @nombre=params[:nombre]
    @correo=params[:correo]
    @telefono=params[:telefono]
    @ciudad=params[:ciudad]
    @direccion=params[:direccion]
    @marca=params[:marca]
    #------
    @nombre_usuario=params[:nombre_usuario]
    @contrasena=params[:contrasena]
    puts ''+@nombre_usuario+''
    @usuario.grabar_usuario_concesionario(@nombre_usuario, @contrasena);
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++metio usuario'
    @concesionario.grabar_concesionario(@rif,@nombre,@correo,@telefono,@ciudad,@direccion,@marca,@nombre_usuario)
    render :text => $tirajson
  end

  #Adriana Santana -->Sino quieren ver una trigra con tigritos recien nacidos por favor no borren esto
  def grabar_ensambladora
    puts 'AQUI'
    @ensambladora = Ensambladora_vehiculos.new
    @usuario = Usuario.new
    @rif=params[:rif]
    @nombre=params[:nombre]
    @correo=params[:correo]
    @telefono=params[:telefono]
    @ciudad=params[:ciudad]
    @direccion=params[:direccion]
    @marca=params[:marca]
    #------
    @nombre_usuario=params[:nombre_usuario]
    @contrasena=params[:contrasena]
    puts ''+@nombre_usuario+''
    @usuario.grabar_usuario_concesionario(@nombre_usuario, @contrasena);
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++metio usuario'
    @ensambladora.grabar_ensambladora(@rif,@nombre,@correo,@telefono,@ciudad,@direccion,@marca,@nombre_usuario)
    render :text => $tirajson
  end
  
  #Ma.Ale
  def buscar_nombreCiudad
    @ciudads = Ciudads.new
    idciudad = params[:idciudad]
    valor = @ciudads.buscarnombreciudad(idciudad)
    render :text => $tirajson
  end
  
  #Ma.Ale
  def buscar_nombreEstado
    @estados = Estados.new
    id_estado = params[:id_estado]
    valor = @estados.buscarnombreEstado(id_estado)
    render :text => $tirajson
  end
  
  def generardataListaGlobal
    @solicitud_vehiculos = Solicitud_vehiculos.all
    @son = Solicitud_vehiculos.count
    @i=1
    @tirajson = '{ "datos": [ '
    @solicitud_vehiculos.each do |solicitud_vehiculos|
      @objproforma = Proformas.new
      proforma = @objproforma.buscarprofroma(@solicitud_vehiculos[@i-1].proformas_id)
      @objcomprador_vehiculo = Comprador_Vehiculo.new
      comprador_vehiculo = @objcomprador_vehiculo.buscarcomprador(proforma.comprador_vehiculos_id)
      @objconcesionario = Concesionario_vehiculos.new
      concesionario = @objconcesionario.buscarconcesionario(proforma.concesionario_vehiculos_id)
      @objdetalle_vehiculo = Detalle_vehiculos.new
      detalle_vehiculos = @objdetalle_vehiculo.buscardetalle_vehiculo(proforma.detalle_vehiculos_id)
      @objvehiculos = Vehiculos.new
      vehiculo = @objvehiculos.buscarid(detalle_vehiculos.vehiculos_id)
      @objmodelo_vehiculos = Modelo_vehiculo.new
      modelo_vehiculos = @objmodelo_vehiculos.buscarmodelovehiculos(vehiculo.modelo_vehiculos_id)
      @objmarca = Marca.new
      marca = @objmarca.buscamarca(modelo_vehiculos.marcas_id)
      #print proforma
      
      if @i<@son
        @tirajson = @tirajson + ' { "nombre": "' + comprador_vehiculo.nombres + '", "posicion": "' + @i + '", "fecha": "' + proforma.fecha.to_s + '", "modelo_vehiculo": "' + modelo_vehiculos.descripcion + '", "concesionarios": "' + concesionario.nombre + '", "marcas": "' + marca.nombre + '"},'
      else
        @tirajson = @tirajson + ' { "nombre": "' + comprador_vehiculo.nombres + '", "posicion": "' + @i + '", "fecha": "' + proforma.fecha.to_s + '", "modelo_vehiculo": "' + modelo_vehiculos.descripcion + '", "concesionarios": "' + concesionario.nombre + '", "marcas": "' + marca.nombre + '"},'
      end
      @i=@i+1
    end
    @tirajson = @tirajson + ' ] }'
    render :text => @tirajson
  end
  
  # def generarDataProforma
    # @proforma = Proforma.all
    # @tira_proformajson = @proforma.to_json
    # render :text => @tira_proformajson
  # end
# 
  # def generarDataCompradorVehiculo
    # @comprador_vehiculos = Comprador_vehiculos.all
    # @tira_compradorjson = @comprador_vehiculos.to_json
    # render :text => @tira_compradorjson
  # end
#   
   # def generardataSolicitudVehiculo
    # @solicitud_vehiculos = Solicitud_vehiculos.all
    # $tira_solicitudjson = @solicitud_vehiculos.to_json
    # render :text => $tira_solicitudjson
  # end
#   
  # def generardataDetalleVehiculo
    # @detalle_vehiculos = Detalle_vehiculos.all
    # $tira_detallejson = @detalle_vehiculos.to_json
    # render :text => $tira_detallejson
  # end
#   
  # def generardataVehiculo
    # @vehiculos = Vehiculos.all
    # $tira_vehiculosjson = @vehiculos.to_json
    # render :text => $tira_vehiculosjson
  # end
# 
  # def generardataModeloVehiculo
    # @modelo_vehiculos = Vehiculos.all
    # $tira_modelovehiculosjson = @modelo_vehiculos.to_json
    # render :text => $tira_modelovehiculosjson
  # end
# 
  # def generardataConcesionario
    # @concesionario_vehiculos = Concesionario_vehiculos.all
    # $tira_concesionariojson = @concesionario_vehiculos.to_json
    # render :text => $tira_concesionariojson
  # end

end
