<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/seguridad/seg.jsp" %>
<%@include file="/utilidades/formatos.jsp" %>
<table width="100%" align="center">
	<tr>
    	<td align="center">
        	<div id="boton_regreso"><strong><img src='/recursos/imagenes/iconos/flecha_izquierda.png'/> REGRESAR A LISTADO DE USUARIOS</strong></div>
        </td>
    </tr>
    <tr>
    	<td align="center">
          <div id="div_agregado_usuarios_explander">
                <div align="center">
                	<table align="center" width="1000px">
                    		<strong>
                            	<p style="color:#081226; font-size:18px"> Agregar Usuario </p>
                            </strong>
                     </table>
                </div>
                <div>
                	<form id="form_usuario_agregado" name="form_usuario_agregado" >
                    	<table>
                        	<tr>
                            	<td colspan="2">
                                	<br/>
                                </td>
                            </tr>
                        	<tr>
                            	<td>
                                	<strong>Nick : </strong>
                                </td>
                            	<td>
                                	<input type="text" id="nick" name="nick"/>
                                </td>
                            </tr>
                        	<tr>
                            	<td>
                                	<strong>Nombre : </strong>
                                </td>
                            	<td>
                                	<input type="text" id="nombre" name="nombre"/>
                                </td>
                            </tr>
                        	<tr>
                            	<td>
                                	<strong>Contraseña : </strong>
                                </td>
                            	<td>
                                	<input type="password" id="pw" name="pw"/>
                                </td>
                            </tr>
                        	<tr>
                            	<td>
                                	<strong>Confirmar Contraseña : </strong>
                                </td>
                            	<td>
                                	<input type="password" id="pw2" name="pw2"/>
                                </td>
                            </tr>
                        	<tr>
                            	<td>
                                	<strong>Tipo : </strong>
                                </td>
                            	<td>
                                	<div id="div_agregado_usuarios_tipo"></div>
                                    <input type="hidden" name="tipo" id="tipo" value="0"/>
                                </td>
                            </tr>
                        	<tr>
                            	<td colspan="2" align="center">
                                	<div id="div_agregado_usuarios_tipo_error"></div>
                                	<br/>
                                </td>
                            </tr>
                        	<tr>
                            	<td colspan="2" align="center">
                                	<button type="button" name="boton_guardar" id="boton_guardar" onClick="guardar()">
                                    	<img src="/recursos/imagenes/iconos/guardar_tabla.png"/> Guardar
                                        <img src="/recursos/imagenes/iconos/guardar_tabla.png"/> 
                                    </button>
                                </td>
                            </tr>
                        	<tr>
                            	<td colspan="2">
                                	<br/>
                                </td>
                            </tr>
                        </table>
                    </form>
          		</div>
          </div>
     	</td>
    </tr>
</table>
<div id="div_agregado_usuarios_acciones"></div>
<script type="application/javascript">

$("#nick").jqxInput({placeHolder: "Nick de Usuario", height: 25, width: 500, minLength: 1, theme: 'energyblue'});
$("#nombre").jqxInput({placeHolder: "Nombre de Usuario", height: 25, width: 500, minLength: 1, theme: 'energyblue'});
$("#pw").jqxPasswordInput({ placeHolder: "Contraseña de Usuario", width: '500px', height: '25px', theme: 'energyblue' });
$("#pw2").jqxPasswordInput({  placeHolder: "Confirmación Contraseña de Usuario",width: '500px', height: '25px', theme: 'energyblue' });
$("#boton_guardar").jqxButton({ width: '300px', height: '25px', theme: 'energyblue' });
	         
var source = [
	"Vendedor",
	"Administrador"
];

$("#div_agregado_usuarios_tipo").jqxDropDownList({ source: source, selectedIndex: 0, width: '500', height: '25', theme: 'energyblue'});

$('#div_agregado_usuarios_tipo').on('select', function (event)
{
    var args = event.args;
    if (args) {                
    var index = args.index;
    var item = args.item;
    var label = item.label;
    var value = item.value;
	if(item.label=="Administrador"){
		$('#tipo').val("1")
	}
	else if(item.label=="Vendedor"){
		$('#tipo').val("0")
	}
}                        
});

$("#div_agregado_usuarios_explander").jqxExpander({ toggleMode: 'none', width: '1004px', showArrow: false, theme: 'energyblue' });

$("#boton_regreso").jqxButton({ disabled: false ,width: '1004px', theme: 'energyblue' });

$("#boton_regreso").on('click', function() {
	pantallaG('/administracion/usuarios.jsp?','main');
});

function guardar(){
	if($('#pw').val()==$('#pw2').val() && $('#pw').val()!=""){
		$('#div_agregado_usuarios_tipo_error').html("");
		if($('#nombre').val()!=""){
			$('#div_agregado_usuarios_tipo_error').html("");
			if($('#nick').val()!=""){
				$('#div_agregado_usuarios_tipo_error').html("");
				pantallaCLF('/administracion/guardar_usuario.jsp','div_agregado_usuarios_acciones','form_usuario_agregado','Agregando Usuarios...');
			}
			else{
				$('#div_agregado_usuarios_tipo_error').html("<strong style='background:red; border: solid 2px yellow; color:yellow'> Error el nick no puede estar vacio</strong>");
			}
		}
		else{
			$('#div_agregado_usuarios_tipo_error').html("<strong style='background:red; border: solid 2px yellow; color:yellow'> Error el nombre no puede estar vacio</strong>");
		}
	}
	else if($('#pw').val()==""){
		$('#div_agregado_usuarios_tipo_error').html("<strong style='background:red; border: solid 2px yellow; color:yellow'> Error la contraseña no puede estar vacia</strong>");
	}
	else{
		$('#div_agregado_usuarios_tipo_error').html("<strong style='background:red; border: solid 2px yellow; color:yellow'> Error las contraseñas proporcionadas no son iguales </strong>");	
	}
}

</script>