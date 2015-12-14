<%@page isErrorPage="true" import="java.io.*" contentType="text/html; charset=iso-8859-1" language="java" %>
<%
if(exception.getMessage().indexOf("segLogin")!=-1)
{
%>
<script type="text/javascript">
	document.location.href = 'http://tallerso:8080';
</script>
<%
}
else
{
%>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
<fieldset><legend><img src="/recursos/imagenes/iconos/tache.png" /> Error de Ejecución del Sistema</legend>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><div align="left"><%= exception.getMessage().replaceAll("\n","<br>") %></div></td>
  </tr>
  <tr>
    <td><div align="left">
<%
	StringWriter stringWriter = new StringWriter();
	PrintWriter printWriter = new PrintWriter(stringWriter);
	exception.printStackTrace(printWriter);
	out.println(stringWriter.toString().replaceAll("\n","<br>"));
	printWriter.close();
	stringWriter.close();
%></div></td>
  </tr>
</table>

</fieldset>
</td>
  </tr>
</table>
<%
}
%>