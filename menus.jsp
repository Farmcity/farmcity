<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/seguridad/seg.jsp" %>
<%
String nombre =(String) (session.getAttribute("nombre")!=null?session.getAttribute("nombre"):"No disponible");
nombre=new String("  Cerrar Sesión : "+nombre+"  ");
String tipo =(String) (session.getAttribute("tipo")!=null?session.getAttribute("tipo"):"0");
%>
<div align="right">
  <div id="button_session">
  <img src="/recursos/imagenes/iconos/logout_new.png" width="14px"/><strong style="font-size:14px"> <%=nombre%></strong><img src="/recursos/imagenes/iconos/logout_new.png" width="14px"/>
  </div>
  </div>
<div id="div_menu_principal">
  <ul>
  <%if(tipo.equals("1")){%>
    <li>Administración
      <ul>
        <li><a href="javaScript:void(0);" onclick="pantallaG('/administracion/usuarios.jsp?','main');">Usuarios</a></li>
      </ul>
    </li>
  <%}%>
	<li>Productos
      <ul>
        <li><a href="javaScript:void(0);" onclick="pantallaG('/productos/productos.jsp?','main');">Listado</a></li>
        <li><a href="javaScript:void(0);" onclick="pantallaG('/productos/categorias.jsp?','main');">Categorias</a></li>
      </ul>
    </li>
  </ul>
</div>
<script type="text/javascript">
$("#button_session").jqxButton({ disabled: false ,width: '500px', theme: 'clasic' });

jQuery(document).ready(function($){
	jQuery("#div_menu_principal").jqxMenu({mode: 'horizontal', theme: 'energyblue'});
});	
$("#button_session").on('click', function() {
	pantallaG('close.jsp?','main');
	location.reload();
});
</script>
