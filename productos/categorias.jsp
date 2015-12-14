<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/seguridad/seg.jsp" %>
<%@include file="/utilidades/formatos.jsp" %>
<%@include file="/conexiones/cxFarmaCity.jsp" %>
<%
Driver dx = (Driver)Class.forName(cxDriver).newInstance();
Connection cx = DriverManager.getConnection(cxString,cxUsername,cxPassword);
PreparedStatement sx, sx1;
ResultSet rst;
String sql= new String("SELECT id_categoria id_categoria2, id_categoria, categoria FROM \"farmacia\".categorias order by id_categoria");
sx = cx.prepareStatement(sql);
rst = sx.executeQuery();
String dataSource= new String("[");
String auxAnterior= new String("");
int cont=0;
while(rst.next())
{
	dataSource += auxAnterior + "{'id':'"+rst.getString("id_categoria")+"','id_categoria2':'"+rst.getString("id_categoria2")+"','id_categoria':'"+rst.getString("id_categoria")+"','categoria':'"+rst.getString("categoria")+"'}";
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
          <div id="div_catalogos_categorias_productos_explander">
                <div align="center">
                	<table align="center" width="1000px">
                		<strong><p style="color:#081226; font-size:18px">CAT&Aacute;LOGO DE CATEGORIAS PRODUCTOS</p></strong>
                    </table>
                </div>
                <div>
                	<div id="div_catalogos_categorias_productos_grid"></div>
          		</div>
          </div>
     </td>
  </tr>
</table>
<div id="div_catalogos_categorias_productos_acciones"></div>
<script type="application/javascript">

$("#div_catalogos_categorias_productos_explander").jqxExpander({ toggleMode: 'none', width: '1004px', showArrow: false, theme: 'energyblue' });

var dataSourceCatalogosCategoriasProductos=<%=dataSource%>;

var sourceCatalogosCategoriasProductos={
	datatype: "json",
    datafields: [
		{ name: 'id_categoria2', type:'number'},
		{ name: 'id_categoria', type:'number'},
		{ name: 'categoria', type:'string'}
	],
    id:'id',
    localdata:dataSourceCatalogosCategoriasProductos,
	pagesize: 12
};
var dataAdapterCatalogosCategoriasProductos = new $.jqx.dataAdapter(sourceCatalogosCategoriasProductos);

var pagerenderCatalogosCategoriasProductos = function () {
	var element = $("<div style='margin-left: 10px; margin-top: 5px; width: 100%; height: 100%;'></div>");
    var datainfo = $("#div_catalogos_categorias_productos_grid").jqxGrid('getdatainformation');
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

var labelCatalogosCategoriasProductos = $("<div style='font-size: 11px; margin: 2px 3px; font-weight: bold; float: left;'></div>");
    labelCatalogosCategoriasProductos.text("1-" + paginginfo.pagesize + ' de ' + datainfo.rowscount);
    labelCatalogosCategoriasProductos.appendTo(element);
    self.labelCatalogosCategoriasProductos = labelCatalogosCategoriasProductos;

var botonExportarCatalogosCategoriasProductos =  $("<div style='float: right; margin-right: 15px;'><img src='/recursos/imagenes/iconos/excel.png' /> <strong>Exportar a Excel </strong></div>");
	botonExportarCatalogosCategoriasProductos.jqxButton({ theme: 'energyblue' });
	botonExportarCatalogosCategoriasProductos.appendTo(element);
	botonExportarCatalogosCategoriasProductos.click(function () {
		$('#div_catalogos_categorias_productos_grid').jqxGrid('exportdata', 'xls', 'Listado_categorias_de_productos_FARMACITY', true, null, false, '/export_server.jsp');
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
		$("#div_catalogos_categorias_productos_grid").jqxGrid('gotonextpage');
	});
    leftButton.click(function () {
    	$("#div_catalogos_categorias_productos_grid").jqxGrid('gotoprevpage');
    });
    return element;
}

$("#div_catalogos_categorias_productos_grid").on('pagechanged', function () {
	var datainfo = $("#div_catalogos_categorias_productos_grid").jqxGrid('getdatainformation');
    var paginginfo = datainfo.paginginformation;
    self.labelCatalogosCategoriasProductos.text(1 + paginginfo.pagenum * paginginfo.pagesize + "-" + Math.min(datainfo.rowscount, (paginginfo.pagenum + 1) * paginginfo.pagesize) + ' de ' + datainfo.rowscount);
});

$("#div_catalogos_categorias_productos_grid").jqxGrid({
	width: 1000,
	height: 400,
	pagerheight: 39,
	altrows: true,
	sortable: true,
	pageable: true,
	theme: 'energyblue',
    source: dataAdapterCatalogosCategoriasProductos,
	pagerrenderer: pagerenderCatalogosCategoriasProductos,
	filterable: true,
	showfilterrow: true,
    columns: [
    	{ text: 'PRODUCTOS', datafield: 'id_categoria2', width: 150, exportable: false ,
			cellsrenderer: 
				function(rowIndex, dataField, cellValue, defaultHTML, columnProperties, rowData){
					return "<button type='button' id='buton_productos_"+cellValue+"' onclick='productosEntrar("+cellValue+");'><strong><img src='/recursos/imagenes/iconos/ver.png' with='20px' height='20px' /> Ver Productos </strong></button>";
				}
		},
    	{ text: 'CLAVE', datafield: 'id_categoria', width: 200, cellsalign: 'center'},
		{ text: 'CATEGORIA', datafield: 'categoria', width: 650, cellsalign: 'center'}
	]
});

function productosEntrar(id){
	pantallaG('/productos/productos_categoria.jsp?id_categoria='+id,'main');	
}
</script>