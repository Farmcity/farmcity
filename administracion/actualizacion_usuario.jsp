<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/conexiones/cxFarmaCity.jsp" %>
<%
Driver dx = (Driver)Class.forName(cxDriver).newInstance();
Connection cx = DriverManager.getConnection(cxString,cxUsername,cxPassword);
PreparedStatement sx=null;
ResultSet rst=null;
String sql=null;
String nombre=new String(request.getParameter("nombre"));
String pw=new String(request.getParameter("pw"));
String tipo=new String(request.getParameter("tipo"));
String nick=new String(request.getParameter("nick"));
boolean script=false;
try{
	sql = "update \"farmacia\".usuarios set nombre=?, pw=?, tipo=? where nick=?";
	sx = cx.prepareStatement(sql);
	sx.setObject(1,nombre);
	sx.setObject(2,pw);
	sx.setObject(3,tipo,Types.NUMERIC);
	sx.setObject(4,nick);
	sx.executeUpdate();
	script=true;
}
catch(Exception excepcion){
	script = false;
	%>
<div style="border:red solid 2px; border-radius:5px; background:yellow" align="center"><img src="/recursos/imagenes/iconos/advertencia.png"> Error al guardar : <%=excepcion%></div>
     <%
}
finally{
	sx.close();
	cx.close();	
}
if(script)
{
%>
<div style="border:red solid 2px; border-radius:5px; background:yellow" align="center"><img src="/recursos/imagenes/iconos/aceptar.png"> Guardado_correctamente </div>
<script type="text/javascript">
pantallaG('/administracion/usuarios.jsp?','main');
</script>
<%
}
%>
