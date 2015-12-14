// JavaScript Document
function nuevoAjax()
{ 
	/* Crea el objeto AJAX. Esta funcion es generica para cualquier utilidad de este tipo, por
	lo que se puede copiar tal como esta aqui */
	var xmlhttp=false;
	try
	{
		// Creacion del objeto AJAX para navegadores no IE
		xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			// Creacion del objet AJAX para IE
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(E)
		{
			if (!xmlhttp && typeof XMLHttpRequest!='undefined') xmlhttp=new XMLHttpRequest();
		}
	}
	return xmlhttp; 
}

function pantallaG (url, element_id) {
    var element =  document.getElementById(element_id);
	var aleat=Math.random(); 
    var fragment_url = url+'&nocache='+aleat;

	var loadHtml  = "<img src='/recursos/imagenes/loading_big.png'>";
	element.innerHTML = loadHtml;
	
    var peticion = nuevoAjax();
	peticion.open("GET", fragment_url);
    peticion.onreadystatechange = function() {
		if (peticion.readyState == 4) {
			var scs=peticion.responseText.extractScript();
			element.innerHTML = peticion.responseText;
			scs.evalScript();
    	}
   }
   peticion.send(null);
}

function pantallaGL (url, element_id, leyenda) {
    var element =  document.getElementById(element_id);
	var aleat=Math.random(); 
    var fragment_url = url+'&nocache='+aleat;

	var loadHtml  = "<p><img src='/recursos/imagenes/loading_big.png'><br/>" + leyenda + "</p>";
	element.innerHTML = loadHtml;
    var peticion = nuevoAjax();
	peticion.open("GET", fragment_url);
    peticion.onreadystatechange = function() {
        if (peticion.readyState == 4) {
			var scs=peticion.responseText.extractScript();    //capturamos los scripts 
			element.innerHTML = peticion.responseText;
			scs.evalScript();       //ahora si, comenzamos a interpretar todo  
        }
    }
	peticion.send(null);
}

function pantallaC (url, element_id) {
    var element =  document.getElementById(element_id);
	var aleat=Math.random(); 
    var fragment_url = url+'&nocache='+aleat;

	var loadHtml  = "<img src='/recursos/imagenes/loading.gif'>";
	element.innerHTML = loadHtml;

    var peticion = nuevoAjax();
	peticion.open("GET", fragment_url);
    peticion.onreadystatechange = function() {
		if (peticion.readyState == 4) {
			var scs=peticion.responseText.extractScript();    //capturamos los scripts 
			element.innerHTML = peticion.responseText;
			scs.evalScript();       //ahora si, comenzamos a interpretar todo  
        }
    }
	peticion.send(null);
}

function pantallaCL (url, element_id, leyenda) {
    var element =  document.getElementById(element_id);
	var aleat=Math.random(); 
    var fragment_url = url+'&nocache='+aleat;

	var loadHtml  = "<img src='/recursos/imagenes/loading.gif'> " + leyenda;
	element.innerHTML = loadHtml;
    var peticion = nuevoAjax();
	peticion.open("GET", fragment_url);
    peticion.onreadystatechange = function() {
        if (peticion.readyState == 4) {
			var scs=peticion.responseText.extractScript();    //capturamos los scripts 
			element.innerHTML = peticion.responseText;
			scs.evalScript();       //ahora si, comenzamos a interpretar todo  
        }
    }
	peticion.send(null);
}

function pantallaB (element_id) {
    var element =  document.getElementById(element_id);
	var loadHtml  = "";
	element.innerHTML = loadHtml;
}

function pantallaGF(url, element_id, formid){
	var element =  document.getElementById(element_id);
	var loadHtml  = "<p><img src='/recursos/imagenes/loading_big.png'><br>Cargando...</p>";
	element.innerHTML = loadHtml;
	
	var Formulario = document.getElementById(formid);
    var longitudFormulario = Formulario.elements.length;
    var cadenaFormulario = "";
    var sepCampos;
    sepCampos = "";
    for (var i=0; i <= Formulario.elements.length-1;i++) {
		if(Formulario.elements[i].type == 'radio')
		{
			if(Formulario.elements[i].checked == true)
			{
				cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
			}
		}
		else
		{
			if(Formulario.elements[i].type == 'checkbox')
			{
				if(Formulario.elements[i].checked == true)
				{
					cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
				}
			}
			else
			{
	    		cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
			}
		}
   	    sepCampos="&";
	}
	var peticion = nuevoAjax();
	peticion.open("POST", url, true);
	peticion.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=ISO-8859-1');
	peticion.onreadystatechange = function () {
		if (peticion.readyState == 4) {
			//escribimos la respuesta
			var scs=peticion.responseText.extractScript();    //capturamos los scripts 
			element.innerHTML = peticion.responseText;
			scs.evalScript();       //ahora si, comenzamos a interpretar todo  
		}
	}
	peticion.send(cadenaFormulario);
}

function pantallaCF(url, element_id, formid){
	var element =  document.getElementById(element_id);
	var loadHtml  = "<img src='/recursos/imagenes/loading.gif'>";
	element.innerHTML = loadHtml;
	
	var Formulario = document.getElementById(formid);
    var longitudFormulario = Formulario.elements.length;
    var cadenaFormulario = "";
    var sepCampos;
    sepCampos = "";
    for (var i=0; i <= Formulario.elements.length-1;i++) {
		if(Formulario.elements[i].type == 'radio')
		{
			if(Formulario.elements[i].checked == true)
			{
				cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
			}
		}
		else
		{
			if(Formulario.elements[i].type == 'checkbox')
			{
				if(Formulario.elements[i].checked == true)
				{
					cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
				}
			}
			else
			{
	    		cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
			}
		}
   	    sepCampos="&";
	}
	var peticion = nuevoAjax();
	peticion.open("POST", url, true);
	peticion.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=ISO-8859-1');
	peticion.onreadystatechange = function () {
		if (peticion.readyState == 4) {
			//escribimos la respuesta
			var scs=peticion.responseText.extractScript();    //capturamos los scripts 
			element.innerHTML = peticion.responseText;
			scs.evalScript();       //ahora si, comenzamos a interpretar todo  
		}
	}
	peticion.send(cadenaFormulario);
}

function pantallaCLF(url, element_id, formid, leyenda){
	var element =  document.getElementById(element_id);
	var loadHtml  = "<img src='/recursos/imagenes/loading.gif'> " + leyenda;
	element.innerHTML = loadHtml;
	
	var Formulario = document.getElementById(formid);
    var longitudFormulario = Formulario.elements.length;
    var cadenaFormulario = "";
    var sepCampos;
    sepCampos = "";
    for (var i=0; i <= Formulario.elements.length-1;i++) {
		if(Formulario.elements[i].type == 'radio')
		{
			if(Formulario.elements[i].checked == true)
			{
				cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
			}
		}
		else
		{
			if(Formulario.elements[i].type == 'checkbox')
			{
				if(Formulario.elements[i].checked == true)
				{
					cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
				}
			}
			else
			{
	    		cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
			}
		}
   	    sepCampos="&";
	}
	var peticion = nuevoAjax();
	peticion.open("POST", url, true);
	peticion.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=ISO-8859-1');
	peticion.onreadystatechange = function () {
		if (peticion.readyState == 4) {
			//escribimos la respuesta
			var scs=peticion.responseText.extractScript();    //capturamos los scripts 
			element.innerHTML = peticion.responseText;
			scs.evalScript();       //ahora si, comenzamos a interpretar todo  
		}
	}
	peticion.send(cadenaFormulario);
}

function pantallaFlashCLF(url, element_id, formid, leyenda){
	var element =  document.getElementById(element_id);
	//var loadHtml  = "<img src='/recursos/imagenes/loading.gif'> " + leyenda;
	//element.innerHTML = loadHtml;
	
	var Formulario = document.getElementById(formid);
    var longitudFormulario = Formulario.elements.length;
    var cadenaFormulario = "";
    var sepCampos;
    sepCampos = "";
    for (var i=0; i <= Formulario.elements.length-1;i++) {
		if(Formulario.elements[i].type == 'radio')
		{
			if(Formulario.elements[i].checked == true)
			{
				cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
			}
		}
		else
		{
			if(Formulario.elements[i].type == 'checkbox')
			{
				if(Formulario.elements[i].checked == true)
				{
					cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
				}
			}
			else
			{
	    		cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
			}
		}
   	    sepCampos="&";
	}
	var peticion = nuevoAjax();
	peticion.open("POST", url, true);
	peticion.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=ISO-8859-1');
	peticion.onreadystatechange = function () {
		if (peticion.readyState == 4) {
			//escribimos la respuesta
			var scs=peticion.responseText.extractScript();    //capturamos los scripts 
			element.innerHTML = peticion.responseText;
			scs.evalScript();       //ahora si, comenzamos a interpretar todo  
		}
	}
	peticion.send(cadenaFormulario);
}
//Funciones de Apoyo
function ajaxSimple(div, url){
	
	var aleat=Math.random();
	if(url.indexOf("?")!=-1)
		url += '&nocache='+aleat;
	else 
		url += '?nocache='+aleat;
		
	$('#'+div).html('<img src="/recursos/imagenes/loading.gif" width="16" height="16">');
	//$('#'+div).load(url);
	$.ajax({
		url: url,
		success: function(response) { $('#'+div).html(response);},
		error: function(response) { $('#'+div).html(response.responseText);}
	});

}

function ajaxFormPost(div, url, form){

	var aleat=Math.random();
	if(url.indexOf("?")!=-1)
		url += '&nocache='+aleat;
	else
		url += '?nocache='+aleat;

	$('#'+div).html('<img src="/recursos/imagenes/loading.gif" width="16" height="16">');
	$.ajax({
		type: 'POST',
		url: url,
		data: $('#'+form).serialize(),
		success: function(response) { $('#'+div).html(response);},
		error: function(response) { $('#'+div).html(response.responseText);}
	});
}

function ajaxBorrar(div){
	$('#'+div).html('');
}

function ajaxSimpleLeyenda(div, url, leyenda){
	var aleat=Math.random();
	if(url.indexOf("?")!=-1)
		url += '&nocache='+aleat;
	else 
		url += '?nocache='+aleat;
		
	$('#'+div).html('<img src="/recursos/imagenes/loading.gif" width="16" height="16"> ' + leyenda);
	//$('#'+div).load(url);
	$.ajax({
		url: url,
		success: function(response) { $('#'+div).html(response);},
		error: function(response) { $('#'+div).html(response.responseText);}
	});

}

