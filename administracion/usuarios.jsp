<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/seguridad/seg.jsp" %>
<%@include file="/utilidades/formatos.jsp" %>
<%@include file="/conexiones/cxFarmaCity.jsp" %>
<%
Driver dx = (Driver)Class.forName(cxDriver).newInstance();
Connection cx = DriverManager.getConnection(cxString,cxUsername,cxPassword);
PreparedStatement sx, sx1;
ResultSet rst;
String sql= new String("SELECT nick nick2, nombre, nick, tipo FROM \"farmacia\".usuarios order by nick");
sx = cx.prepareStatement(sql);
rst = sx.executeQuery();
String dataSource= new String("[");
String auxAnterior= new String("");
int cont=0;
while(rst.next())
{
	dataSource += auxAnterior + "{'id':'"+cont+"','nombre':'"+rst.getString("nombre")+"','nick2':'"+rst.getString("nick2")+"','nick':'"+rst.getString("nick")+"','tipo':'"+rst.getString("tipo")+"'}";
	auxAnterior = ",";
	cont++;
}
dataSource += "]";
rst.close();
sx.close();
cx.close();
%>
<table width="100%" border="0" cellspacing="10" cellpadding="0">
  <tr align="center">
    <td align="center">
          <div id="div_catalogos_usuarios_explander">
                <div align="center">
                	<table align="center" width="1000px">
                		<strong><p style="color:#081226; font-size:18px">CAT&Aacute;LOGO DE USUARIOS</p></strong>
                    </table>
                </div>
                <div>
                	<div id="div_catalogos_usuarios_grid"></div>
          		</div>
          </div>
     </td>
  </tr>
</table>
<div id="div_catalogos_usuarios_acciones"></div>
<script type="application/javascript">

$("#div_catalogos_usuarios_explander").jqxExpander({ toggleMode: 'none', width: '1004px', showArrow: false, theme: 'energyblue' });

var dataSourceCatalogosusuarios=<%=dataSource%>;

var sourceCatalogosusuarios={
	datatype: "json",
    datafields: [
		{ name: 'id', type:'string'},
		{ name: 'nick', type:'string'},
		{ name: 'nick2', type:'string'},
		{ name: 'nombre', type:'string'},
		{ name: 'tipo', type:'string'}
	],
    id:'id',
    localdata:dataSourceCatalogosusuarios,
	pagesize: 12
};

var dataAdapterCatalogosusuarios = new $.jqx.dataAdapter(sourceCatalogosusuarios);

var pagerenderCatalogosusuarios = function () {
	var element = $("<div style='margin-left: 10px; margin-top: 5px; width: 100%; height: 100%;'></div>");
    var datainfo = $("#div_catalogos_usuarios_grid").jqxGrid('getdatainformation');
    var paginginfo = datainfo.paginginformation;
    var leftButton = $("<div style='padding: 0px; float: left;'><div style='margin-left: 9px; width: 16px; height: 16px;'></div></div>");
    leftButton.find('div').addClass('jqx-icon-arrow-left');
    leftButton.width(36);
    leftButton.jqxButton({ theme: 'energyblue' });

var rightButton = $("<div style='padding: 0px; margin: 0px 3px; float: left;'><div style='margin-left: 9px; width: 16px; height: 16px;'></div></div>");
    rightButton.find('div').addClass('jqx-icon-arrow-right');
    rightButton.width(36);
    rightButton.jqxButton({ theme: 'energyblue' });
    leftButton.appendTo(element);
    rightButton.appendTo(element);

var labelCatalogosusuarios = $("<div style='font-size: 11px; margin: 2px 3px; font-weight: bold; float: left;'></div>");
    labelCatalogosusuarios.text("1-" + paginginfo.pagesize + ' de ' + datainfo.rowscount);
    labelCatalogosusuarios.appendTo(element);
    self.labelCatalogosusuarios = labelCatalogosusuarios;

var botonExportarCatalogosusuarios =  $("<div style='float: right; margin-right: 15px;'><img src='/recursos/imagenes/iconos/excel.png' /> <strong>Exportar a Excel </strong></div>");
	botonExportarCatalogosusuarios.jqxButton({ theme: 'energyblue' });
	botonExportarCatalogosusuarios.appendTo(element);
	botonExportarCatalogosusuarios.click(function () {
		$('#div_catalogos_usuarios_grid').jqxGrid('exportdata', 'xls', 'Listado_de_usuarios_FARMACITY', true, null, false, '/export_server.jsp');
	});
var botonAgregarUsuarios =  $("<div style='float: right; margin-right: 15px;'><img src='/recursos/imagenes/iconos/agregar.png' /> <strong>Agregar</strong></div>");
	botonAgregarUsuarios.jqxButton({ theme: 'energyblue' });
	botonAgregarUsuarios.appendTo(element);
	botonAgregarUsuarios.click(function () {
		pantallaGL('/administracion/agregar_usuario.jsp?','main','Cargando...');
	});
	
var handleStates = function (event, button, className, add) {
    	button.on(event, function () {
        	if (add == true) {
            	button.find('div').addClass(className);
            }
        	else button.find('div').removeClass(className);
    	});
	}
	
	rightButton.click(function () {
		$("#div_catalogos_usuarios_grid").jqxGrid('gotonextpage');
	});
    leftButton.click(function () {
    	$("#div_catalogos_usuarios_grid").jqxGrid('gotoprevpage');
    });
    return element;
}

$("#div_catalogos_usuarios_grid").on('pagechanged', function () {
	var datainfo = $("#div_catalogos_usuarios_grid").jqxGrid('getdatainformation');
    var paginginfo = datainfo.paginginformation;
    self.labelCatalogosusuarios.text(1 + paginginfo.pagenum * paginginfo.pagesize + "-" + Math.min(datainfo.rowscount, (paginginfo.pagenum + 1) * paginginfo.pagesize) + ' de ' + datainfo.rowscount);
});

$("#div_catalogos_usuarios_grid").jqxGrid({
	width: 1000,
	height: 400,
	pagerheight: 39,
	altrows: true,
	sortable: true,
	pageable: true,
	theme: 'energyblue',
    source: dataAdapterCatalogosusuarios,
	pagerrenderer: pagerenderCatalogosusuarios,
	filterable: true,
	showfilterrow: true,
    columns: [
    	{ text: 'EDITAR', datafield: 'nick2', width: 100, exportable: false ,
			cellsrenderer: 
				function(rowIndex, dataField, cellValue, defaultHTML, columnProperties, rowData){
					return "<button type='button' id='buton_editar_"+cellValue+"' onclick='editarUsuario(\""+cellValue+"\");'><strong><img src='/recursos/imagenes/iconos/editar.png' with='20px' height='20px' /> Editar</strong></button>";
				}
		},
		{ text: 'NICK USUARIO', datafield: 'nick', width: 300 },
		{ text: 'NOMBRE USUARIO', datafield: 'nombre', width: 300 },
		{ text: 'TIPO USUARIO', datafield: 'tipo', width: 300, 
			cellsrenderer: 
				function(rowIndex, dataField, cellValue, defaultHTML, columnProperties, rowData){
					if(cellValue=="1"){
						return "Administrador";
					}
					else{
						return "Vendedor";
					}
				}
		}
	]
});

function editarUsuario(nick){
	pantallaGL('/administracion/edicion_usuario.jsp?nick='+nick,'main','Cargando...');
} 
</script>