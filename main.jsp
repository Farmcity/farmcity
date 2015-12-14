<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/seguridad/seg.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FarmaCITY</title>

<link href="/recursos/css/cimaconsultores.css" rel="stylesheet" type="text/css" />

<script type="application/javascript" src="/recursos/ajax/interpretadorAjax.js"></script>
<script type="application/javascript" src="/recursos/ajax/saga_ajax.js"></script>
<script type="text/javascript" src="/recursos/javascript/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/recursos/javascript/loopj-jquery-tokeninput-201d2d1/src/jquery.tokeninput.js"></script>
<script type="text/javascript" src="/recursos/javascript/jqwidgets_3.2.2/jqwidgets/jqx-all.js"></script>
<script type="text/javascript" src="/recursos/javascript/jqwidgets_3.2.2/jqwidgets/globalization/globalize.js"></script>
<link href="/recursos/javascript/loopj-jquery-tokeninput-201d2d1/styles/token-input.css" rel="stylesheet" type="text/css" />
<link href="/recursos/javascript/loopj-jquery-tokeninput-201d2d1/styles/token-input-facebook.css" rel="stylesheet" type="text/css" />
<link href="/recursos/javascript/jqwidgets_3.2.2/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css" />
<link href="/recursos/javascript/jqwidgets_3.2.2/jqwidgets/styles/jqx.office.css" rel="stylesheet" type="text/css" />
<link href="/recursos/javascript/jqwidgets_3.2.2/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css" />

</head>

<body background="recursos/imagenes/fondo_puntos.png">
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td><div id="header" align="right"></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="left" id="menus"></div></td>
  </tr>
  <tr>
    <td valign="top"><div id="main" align="center"></div></td>
  </tr>
  <tr>
    <td><div id="footer" align="center"></div></td>
  </tr>
</table>
<div id="div_ventana01">
	<div></div>
    <div id="div_ventana01_content"></div>
</div>

<script type="application/x-javascript">
pantallaC('/header.jsp?','header');
pantallaC('/menus.jsp?','menus');
</script>
</body>
</html>
