<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/conexiones/cxFarmaCity.jsp" %>
<%
Driver dx = (Driver)Class.forName(cxDriver).newInstance();
Connection cx = DriverManager.getConnection(cxString,cxUsername,cxPassword);
PreparedStatement sx, sx1;
ResultSet rst;
String sql;
String nick = request.getParameter("nick");
String pw = request.getParameter("pw");
boolean script = false;

sql = "select nombre,tipo from \"farmacia\".usuarios where nick = ? and pw = ?";
sx = cx.prepareStatement(sql);
sx.setObject(1,nick);
sx.setObject(2,pw,Types.OTHER);
rst = sx.executeQuery();

if(rst.next())
{
	session.setAttribute("nick",nick);
	session.setAttribute("nombre",rst.getString("nombre"));
	session.setAttribute("tipo",rst.getString("tipo"));
	session.setAttribute("dominio","tallerSO");
	script = true;
}
else
{
%>
<strong><img src="/recursos/imagenes/iconos/advertencia.png"> Error de verifique usuario o password incorrecto</strong>
<%
}
rst.close();
sx.close();
cx.close();
if(script)
{
%>
<script type="text/javascript">
	document.location.href = '/main.jsp';
</script>
<%
}
%>