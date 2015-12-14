<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/conexiones/cxFarmaCity.jsp" %>
<%
Driver dx = (Driver)Class.forName(cxDriver).newInstance();
Connection cx = DriverManager.getConnection(cxString,cxUsername,cxPassword);
PreparedStatement sx=null, sx1=null;
ResultSet rst=null;
String sql=null, sql1=null;
String nombre=new String(request.getParameter("nombre"));
String pw=new String(request.getParameter("pw"));
String tipo=new String(request.getParameter("tipo"));
String nick=new String(request.getParameter("nick"));
boolean script=false;
try{
	sql= new String("select count(*) c from \"farmacia\".usuarios where nick=?");
	sx = cx.prepareStatement(sql);
	sx.setObject(1,nick);
	rst=sx.executeQuery();
	if(rst.next()){
		out.print("Contador: "+rst.getInt("c"));
		if(rst.getInt("c")==0){
			sql1 = new String("insert into \"farmacia\".usuarios(nombre, pw, tipo, nick) values (?,?,?,?)");
			sx1 = cx.prepareStatement(sql1);
			sx1.setObject(1,nombre);
			sx1.setObject(2,pw);
			sx1.setObject(3,tipo,Types.NUMERIC);
			sx1.setObject(4,nick);
			sx1.executeUpdate();
			script=true;
		}
		else{
			%>
        	<div style="border:red solid 2px; border-radius:5px; background:yellow" align="center"><img src="/recursos/imagenes/iconos/advertencia.png"> Error al nick ya existe</div>
            <%
		}
	}
}
catch(Exception excepcion){
	script = false;
	%>
		<div style="border:red solid 2px; border-radius:5px; background:yellow" align="center"><img src="/recursos/imagenes/iconos/advertencia.png"> Error al guardar : <%=excepcion%></div>
     <%
}
finally{
	rst.close();
	sx1.close();
	sx.close();
	cx.close();	
}
if(script){
	%>
    	<div style="border:red solid 2px; border-radius:5px; background:yellow" align="center"><img src="/recursos/imagenes/iconos/aceptar.png"/> Guardado Correctamente </div>
    	<script type="text/javascript">
    		pantallaG('/administracion/usuarios.jsp?','main');
    	</script>
	<%
}
%>