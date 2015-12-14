<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/seguridad/seg.jsp" %>
<%@include file="/utilidades/formatos.jsp" %>
<%@include file="/conexiones/cxFarmaCity.jsp" %>
<%
String id_categoria=new String(request.getParameter("id_categoria"));
String categoria=new String("");
Driver dx = (Driver)Class.forName(cxDriver).newInstance();
Connection cx = DriverManager.getConnection(cxString,cxUsername,cxPassword);
PreparedStatement sx, sx1;
ResultSet rst;
String sql= new String("SELECT p.id_producto, p.clave_producto, p.descripcion, c.categoria , p.producto, p.precio, p.cantidad FROM \"farmacia\".productos p join \"farmacia\".categorias c on (p.id_categoria=c.id_categoria) where p.id_categoria=? order by id_producto");
sx = cx.prepareStatement(sql);
sx.setObject(1,id_categoria,Types.NUMERIC);
rst = sx.executeQuery();
String dataSource= new String("[");
String auxAnterior= new String("");
int cont=0;
while(rst.next())
{
	categoria=new String(rst.getString("categoria"));
	dataSource += auxAnterior + "{'id':'"+rst.getString("id_producto")+"','id_producto':'"+rst.getString("id_producto")+"','clave_producto':'"+rst.getString("clave_producto")+"','descripcion':'"+rst.getString("descripcion")+"','categoria':'"+rst.getString("categoria")+"','producto':'"+rst.getString("producto")+"','precio':'"+rst.getString("precio")+"','cantidad':'"+rst.getString("cantidad")+"'}";
	auxAnterior = ",";
	cont++;
}
dataSource += "]";
rst.close();
sx.close();
cx.close();
%>
<table width="100%" border="0" cellspacing="10" cellpadding="0">
	<tr>
    	<td align="center">
        	<div id="boton_regreso"><strong><img src='/recursos/imagenes/iconos/flecha_izquierda.png'/> REGRESAR A LISTADO DE CATEGORIAS</strong></div>
        </td>
    </tr>
  <tr align="center">
    <td align="center">
          <div id="div_catalogos_productos_explander">
                <div align="center">
                	<table align="center" width="1000px">
                		<strong><p style="color:#081226; font-size:18px">LISTADO DE PRODUCTOS (<%=categoria%>)</p></strong>
                    </table>
                </div>
                <div>
                	<div id="div_catalogos_productos_grid"></div>
          		</div>
          </div>
     </td>
  </tr>
</table>
<div id="div_catalogos_productos_acciones"></div>
<script type="application/javascript">

$("#div_catalogos_productos_explander").jqxExpander({ toggleMode: 'none', width: '1004px', showArrow: false, theme: 'energyblue' });

var dataSourceCatalogosProductos=<%=dataSource%>;

var sourceCatalogosProductos={
	datatype: "json",
    datafields: [
		{ name: 'clave_producto', type:'string'},
		{ name: 'descripcion', type:'string'},
		{ name: 'categoria', type:'string'},
		{ name: 'producto', type:'string'},
		{ name: 'precio', type:'number'},
		{ name: 'cantidad', type:'string'}
	],
    id:'id',
    localdata:dataSourceCatalogosProductos,
	pagesize: 12
};
var dataAdapterCatalogosProductos = new $.jqx.dataAdapter(sourceCatalogosProductos);

var pagerenderCatalogosProductos = function () {
	var element = $("<div style='margin-left: 10px; margin-top: 5px; width: 100%; height: 100%;'></div>");
    var datainfo = $("#div_catalogos_productos_grid").jqxGrid('getdatainformation');
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

var labelCatalogosProductos = $("<div style='font-size: 11px; margin: 2px 3px; font-weight: bold; float: left;'></div>");
    labelCatalogosProductos.text("1-" + paginginfo.pagesize + ' de ' + datainfo.rowscount);
    labelCatalogosProductos.appendTo(element);
    self.labelCatalogosProductos = labelCatalogosProductos;

var botonExportarCatalogosProductos =  $("<div style='float: right; margin-right: 15px;'><img src='/recursos/imagenes/iconos/excel.png' /> <strong>Exportar a Excel </strong></div>");
	botonExportarCatalogosProductos.jqxButton({ theme: 'energyblue' });
	botonExportarCatalogosProductos.appendTo(element);
	botonExportarCatalogosProductos.click(function () {
		$('#div_catalogos_productos_grid').jqxGrid('exportdata', 'xls', 'Listado_de_productos_FARMACITY', true, null, false, '/export_server.jsp');
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
		$("#div_catalogos_productos_grid").jqxGrid('gotonextpage');
	});
    leftButton.click(function () {
    	$("#div_catalogos_productos_grid").jqxGrid('gotoprevpage');
    });
    return element;
}

$("#div_catalogos_productos_grid").on('pagechanged', function () {
	var datainfo = $("#div_catalogos_productos_grid").jqxGrid('getdatainformation');
    var paginginfo = datainfo.paginginformation;
    self.labelCatalogosProductos.text(1 + paginginfo.pagenum * paginginfo.pagesize + "-" + Math.min(datainfo.rowscount, (paginginfo.pagenum + 1) * paginginfo.pagesize) + ' de ' + datainfo.rowscount);
});

$("#div_catalogos_productos_grid").jqxGrid({
	width: 1000,
	height: 400,
	pagerheight: 39,
	altrows: true,
	sortable: true,
	pageable: true,
	theme: 'energyblue',
    source: dataAdapterCatalogosProductos,
	pagerrenderer: pagerenderCatalogosProductos,
	filterable: true,
	showfilterrow: true,
    columns: [
    	{ text: 'CLAVE', datafield: 'clave_producto', width: 150, cellsalign: 'center'},
		{ text: 'PRODUCTO', datafield: 'producto', width: 200},
		{ text: 'DESCRIPCION', datafield: 'descripcion', width: 300},
		{ text: 'CATEGORIA', datafield: 'categoria', width: 150},
		{ text: 'PRECIO', datafield: 'precio', width: 100, cellsalign: 'center', cellsformat: 'c2'},
		{ text: 'N°', datafield: 'cantidad', width: 100, cellsalign: 'center' }
	]
});

$("#boton_regreso").jqxButton({ disabled: false ,width: '1004px', theme: 'energyblue' });

$("#boton_regreso").on('click', function() {
	pantallaG('/productos/categorias.jsp?','main');
});

</script>