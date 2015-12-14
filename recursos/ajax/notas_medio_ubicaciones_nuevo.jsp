<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/seguridad/seg.jsp" %>
<%@include file="/conexiones/cxCima.jsp" %>
<%
Driver dx = (Driver)Class.forName(cxCimaDriver).newInstance();
Connection cx = DriverManager.getConnection(cxCimaString,cxCimaUsername,cxCimaPassword);
PreparedStatement sx,sx1;
ResultSet rst ,rst1 ;
String sql;
%>
<%
String idNota = request.getParameter("id_nota");

%>
<div id="notas_medios_nuevo_medio_expander"><h1 align="center" style="color:#0F0">Medios y Secciones</h1>
 <div> 
   <form id="notas_medios_nuevo_medio_captura">
     <br />
       <table cellpadding="3" border="10" bordercolordark="#000000">
         <tr>
             <td align="center" width="1000">MEDIO</td>
             <td align="center" width="1000">SECCIÓN</td>
             <td align="center" width="1000">UBICACIÓN</td>
         </tr>
         
         <tr>
		   <td align="center">
<select style="width:200px" name="select_medio_combo_box_<%=idNota%>" id="select_medio_combo_box_<%=idNota%>"
onchange="">
            
<%
		sql = "select * from medios order by nombre";
		sx1 = cx.prepareStatement(sql);
		rst1 = sx1.executeQuery();
		while(rst1.next())
		{
%>
<option value="<%= rst1.getString("id_medio") %>"><%= rst1.getString("nombre") %></option>
<%
		}
		rst1.close();
		sx1.close();
%>
</select>

           </td>
           <td align="center">
<select style="width:200px" name="select_seccion_combo_box_<%=idNota%>" id="select_seccion_combo_box_<%=idNota%>"
onchange="javaScript:pantallaC('/contenidos/notas_medio_ubicaciones_guardar.jsp?id_nota=<%= idNota %>&id_seccion='+this[this.selectedIndex].value+'&id_medio='+document.getElementById('select_medio_combo_box_<%=idNota%>').value,'div_notas_medio_ubicaciones_nuevo_acciones');"> 
<%
		sql = "select * from secciones order by nombre";
		sx = cx.prepareStatement(sql);
		rst = sx.executeQuery();
		while(rst.next())
		{
%>
<option value="<%= rst.getString("id_seccion") %>"><%= rst.getString("nombre")%></option>
<%
		}
		rst.close();
		sx.close();
%>
</select>

           </td>
           <td>
<input name="ubicacion" type="text" id="ubicacion" size="50"/>
           </td>
         </tr>
         <tr>
         <td align="center" valign="top">
          
          
           <button type="button" id="notas_medios_nuevo_boton_aceptar" onclick="javaScript:pantallaGF('/contenidos/notas_medio_ubicaciones_guardar.jsp?id_nota=<%=idNota%>','div_notas_medio_ubicaciones_nuevo_acciones','notas_medios_nuevo_medio_captura');"> <img src="/recursos/imagenes/iconos/aceptar.png" width="16" height="16"/> Aceptar</button></td>
           <td align="center">
          
           
           <button type="button" id="notas_medios_nuevo_boton_cancelar" onclick="$('#div_ventana03_content').jqxWindow('close')"> <img src="/recursos/imagenes/iconos/cancelar.png" width="16" height="16" /> Cancelar</button>
           </td>
         </tr>
         <tr>
<td colspan="6"><div id="div_notas_medio_ubicaciones_nuevo_acciones"></div></td>
         </tr>
</table>
</form>

</div>
</div>


<script type="text/javascript">
function hola(){alert("hola");}
$("#notas_medios_nuevo_medio_expander").jqxMenu({mode: 'vertical', theme: 'office'});
$("#notas_medios_nuevo_boton_aceptar").jqxButton({ theme: 'office' });
$("#notas_medios_nuevo_boton_cancelar").jqxButton({ theme: 'office' });
</script>
<%
cx.close();
%>