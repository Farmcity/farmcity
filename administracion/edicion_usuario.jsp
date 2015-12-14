<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/seguridad/seg.jsp" %>
<%@include file="/utilidades/formatos.jsp" %>
<%@include file="/conexiones/cxFarmaCity.jsp" %>
<%
Driver dx = (Driver)Class.forName(cxDriver).newInstance();
Connection cx = DriverManager.getConnection(cxString,cxUsername,cxPassword);
PreparedStatement sx;
ResultSet rst;
String nick=request.getParameter("nick");
String sql= new String("SELECT nick nick2, nombre, nick, tipo, pw FROM \"farmacia\".usuarios where nick=?");
sx = cx.prepareStatement(sql);
sx.setObject(1,nick);
rst = sx.executeQuery();
if(rst.next())
{
	%>
    	
<table width="100%" align="center">
	<tr>
    	<td align="center">
        	<div id="boton_regreso"><strong><img src='/recursos/imagenes/iconos/flecha_izquierda.png'/> REGRESAR A LISTADO DE USUARIOS</strong></div>
        </td>
    </tr>
    <tr>
    	<td align="center">
          <div id="div_edicion_usuarios_explander">
                <div align="center">
                	<table align="center" width="1000px">
                    		<strong>
                            	<p style="color:#081226; font-size:18px"> Edicion de Usuario : <strong style="color:#9A1A1A"><%=nick%></strong></p>
                            </strong>
                     </table>
                </div>
                <div>
                	<form id="form_usuario" name="form_usuario" onsubmit="pantallaCLF('/administracion/actualizacion_usuario.jsp','div_edicion_usuarios_acciones','form_usuario','Actualizando Datos...');">
                        <input type="hidden" name="nick" id="nick" value="<%=nick%>"/>
                    	<table>
                        	<tr>
                            	<td colspan="2">
                                	<br/>
                                </td>
                            </tr>
                        	<tr>
                            	<td>
                                	<strong>Nombre : </strong>
                                </td>
                            	<td>
                                	<input type="text" id="nombre" name="nombre" value="<%=rst.getString("nombre")%>"/>
                                </td>
                            </tr>
                        	<tr>
                            	<td colspan="2" align="center">
                                	<div id="div_edicion_usuarios_nombre_error"></div>
                                </td>
                            </tr>
                        	<tr>
                            	<td>
                                	<strong>Contraseña : </strong>
                                </td>
                            	<td>
                                	<input type="password" id="pw" name="pw" value="<%=rst.getString("pw")%>"/>
                                </td>
                            </tr>
                        	<tr>
                            	<td>
                                	<strong>Confirmar Contraseña : </strong>
                                </td>
                            	<td>
                                	<input type="password" id="pw2" name="pw2" value="<%=rst.getString("pw")%>"/>
                                </td>
                            </tr>
                        	<tr>
                            	<td colspan="2" align="center">
                                	<div id="div_edicion_usuarios_pw_error"></div>
                                </td>
                            </tr>
                        	<tr>
                            	<td>
                                	<strong>Tipo : </strong>
                                </td>
                            	<td>
                                	<div id="div_edicion_usuarios_tipo"></div>
                                    <input type="hidden" name="tipo" id="tipo" value="<%=rst.getString("tipo")%>"/>
                                </td>
                            </tr>
                        	<tr>
                            	<td colspan="2" align="center">
                                	<div id="div_edicion_usuarios_tipo_error"></div>
                                	<br/>
                                </td>
                            </tr>
                        	<tr>
                            	<td colspan="2" align="center">
                                	<button type="button" name="boton_guardar" id="boton_guardar" onClick="guardarEdicion()">
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
<div id="div_edicion_usuarios_acciones"></div>
<script type="application/javascript">

$("#nombre").jqxInput({placeHolder: "Nombre de Usuario", height: 25, width: 500, minLength: 1, theme: 'energyblue'});
$("#pw").jqxPasswordInput({  width: '500px', height: '25px', theme: 'energyblue' });
$("#pw2").jqxPasswordInput({  width: '500px', height: '25px', theme: 'energyblue' });
$("#boton_guardar").jqxButton({ width: '300px', height: '25px', theme: 'energyblue' });
	         
var source = [
	"Vendedor",
	"Administrador"
];

$("#div_edicion_usuarios_tipo").jqxDropDownList({ source: source, selectedIndex: <%=rst.getString("tipo")%>, width: '500', height: '25', theme: 'energyblue'});

$('#div_edicion_usuarios_tipo').on('select', function (event)
{
    var args = event.args;
    if (args) {                
    var index = args.index;
    var item = args.item;
    var label = item.label;
    var value = item.value;
	if(item.label=="Administrador"){
		$('#div_edicion_usuarios_tipo_error').html("");
		$('#tipo').val("1")
	}
	else if(item.label=="Vendedor"){
		$('#div_edicion_usuarios_tipo_error').html("");
		$('#tipo').val("0")
	}
}                        
});

$("#div_edicion_usuarios_explander").jqxExpander({ toggleMode: 'none', width: '1004px', showArrow: false, theme: 'energyblue' });

$("#boton_regreso").jqxButton({ disabled: false ,width: '1004px', theme: 'energyblue' });

$("#boton_regreso").on('click', function() {
	pantallaG('/administracion/usuarios.jsp?','main');
});

function guardarEdicion(){
	if($('#tipo').val()!="-1"){
		$('#div_edicion_usuarios_tipo_error').html("");
		if($('#pw').val()==$('#pw2').val() && $('#pw').val()!=""){
			$('#div_edicion_usuarios_pw_error').html("");
			if($('#nombre').val()!=""){
				$('#div_edicion_usuarios_nombre_error').html("");
				pantallaCLF('/administracion/actualizacion_usuario.jsp','div_edicion_usuarios_acciones','form_usuario','Actualizando Datos...');
			}
			else{
				$('#div_edicion_usuarios_nombre_error').html("<strong style='background:red; border: solid 2px yellow; color:yellow'> Error el nombre no puede estar vacio</strong>");
			}
		}
		else if($('#pw').val()==""){
			$('#div_edicion_usuarios_pw_error').html("<strong style='background:red; border: solid 2px yellow; color:yellow'> Error la contraseña no puede estar vacia</strong>");
		}
		else{
			$('#div_edicion_usuarios_pw_error').html("<strong style='background:red; border: solid 2px yellow; color:yellow'> Error las contraseñas proporcionadas no son iguales </strong>");	
		}
	}
	else{
		$('#div_edicion_usuarios_tipo_error').html("<strong style='background:red; border: solid 2px yellow; color:yellow'> Error seleccione una opcion valida </strong>");
	}
}

</script>
    <%
}
rst.close();
sx.close();
cx.close();
%>