
Ext.define('indicadoresdeta', {
    extend: 'Ext.window.Window',
	y : 237,
	x : 485,
    height: 346,
    width: 458,
    title: 'Configuracion',

    initComponent: function() {
        var me = this;

        Ext.applyIf(me, {
            items: [
                {
                    xtype: 'form',
                    height: 323,
                    layout: {
                        type: 'absolute'
                    },
                    bodyPadding: 10,
                    items: [
                        {
                            xtype: 'fieldset',
                            x: 10,
                            y: 10,
                            height: 280,
                            layout: {
                                type: 'absolute'
                            },
                            title: 'Detalles del Indicador',
                            items: [
                                {
                                    xtype: 'label',
                                    x: 100,
                                    y: 10,
                                    text: 'Valores establecidos'
                                },
                                {
                                    xtype: 'label',
                                    x: 140,
                                    y: 200,
                                    height: 20,
                                    id: 'telefono_resp',
                                    text: ''
                                },
                                {
                                    xtype: 'label',
                                    x: 80,
                                    y: 200,
                                    text: 'Teléfono:'
                                },
                                {
                                    xtype: 'label',
                                    x: 140,
                                    y: 170,
                                    id: 'correo_resp',
                                    text: ''
                                },
                                {
                                    xtype: 'label',
                                    x: 90,
                                    y: 170,
                                    height: 20,
                                    text: 'Correo:'
                                },
                                {
                                    xtype: 'label',
                                    x: 140,
                                    y: 140,
                                    height: 20,
                                    width: 130,
                                    id: 'nombre_resp',
                                    text: ''
                                },
                                {
                                    xtype: 'label',
                                    x: 50,
                                    y: 140,
                                    height: 20,
                                    width: 90,
                                    text: 'Responsable:'
                                },
                                {
                                    xtype: 'label',
                                    x: 270,
                                    y: 10,
                                    text: 'Fechas validas'
                                },
                                {
                                    xtype: 'label',
                                    x: 30,
                                    y: 40,
                                    height: 20,
                                    width: 40,
                                    text: 'Meta'
                                },
                                {
                                    xtype: 'label',
                                    x: 10,
                                    y: 70,
                                    text: 'Amarillo'
                                },
                                {
                                    xtype: 'label',
                                    x: 30,
                                    y: 100,
                                    text: 'Rojo'
                                },
                                {
                                    xtype: 'label',
                                    x: 120,
                                    y: 40,
                                    id: 'valor_meta',
                                    text: ''
                                },
                                {
                                    xtype: 'label',
                                    x: 120,
                                    y: 70,
                                    id: 'valor_amarillo',
                                    text: ''
                                },
                                {
                                    xtype: 'label',
                                    x: 120,
                                    y: 100,
                                    id: 'valor_rojo',
                                    text: ''
                                },
                                {
                                    xtype: 'label',
                                    x: 280,
                                    y: 70,
                                    height: 20,
                                    id: 'fecha_amarillo',
                                    text: ''
                                },
                                {
                                    xtype: 'label',
                                    x: 280,
                                    y: 100,
                                    height: 20,
                                    id: 'fecha_rojo',
                                    text: ''
                                },
                                {
                                    xtype: 'label',
                                    x: 280,
                                    y: 40,
                                    id: 'fecha_meta',
                                    text: ''
                                }
                            ]
                        }
                    ]
                }
            ]
        });

        me.callParent(arguments);
    }
});

function asignarDetalleIndicador() {
	alert('metodo detalle'+id_indicador1);
	Ext.Ajax.request({
		url : 'menu_ensambladora/generarDataUsuarioIndicador',
		params : {
			ajax : 'true',
			funcion : 'generarDataUsuarioIndicador',
			idindicador : id_indicador1
		},
		success : function(exito, request) {
			datos = Ext.JSON.decode(exito.responseText);
			alert('PasoImagen');
			if (datos.exito == 'false') {
				Ext.Msg.alert("Error", datos.msg);
				alert('dentro if');
			} else {
				alert('dentro else');
				Ext.getCmp('valor_meta').setText(datos.valor_meta);
				Ext.getCmp('fecha_meta').setText(datos.fecha_meta);
				Ext.getCmp('valor_amarillo').setText(datos.valor_amarillo);
				Ext.getCmp('valor_rojo').setText(datos.valor_rojo);
				Ext.getCmp('fecha_amarillo').setText(datos.fecha_amarillo);
				Ext.getCmp('fecha_rojo').setText(datos.fecha_rojo);
				Ext.getCmp('nombre_resp').setText(datos.responsable);
				Ext.getCmp('correo_resp').setText(datos.correo_responsable);
				Ext.getCmp('telefono_resp').setText(datos.telefono);
			}
		},
		failure : function() {
			Ext.Msg.alert("Error", "Servidor NO Conectado!!");
		}
	});
}
