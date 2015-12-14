<%
boolean segNick = session.getAttribute("nick")==null?false:session.getAttribute("nick").equals("")?false:true;
boolean segDominio = session.getAttribute("dominio")==null?false:session.getAttribute("dominio").equals("tallerSO")?true:false;

if(!segNick || !segDominio)
{
	throw new Exception("segLogin");
}

/*
String cambiarPassword = session.getAttribute("cambiar_password")==null?"":session.getAttribute("cambiar_password").toString();
if(cambiarPassword.equals("1"))
{


<script type="text/javascript">
Modalbox.show('/sistema/admin/set_pw_mail.jsp', {title: 'Establecer Password y datos de contacto', width: 400, height: 300, overlayClose: false});
</script>


}

String privilegio = request.getParameter("privilegio")==null?"":request.getParameter("privilegio");

if(!privilegio.equals(""))
	if(session.getAttribute(privilegio).toString().equals("f"))
	{
		out.println("<img src='/recursos/imagenes/iconos/advertencia.png' /> Sin Privilegios para esta Secci&oacute;n");
		out.close();
	}
*/
%>
