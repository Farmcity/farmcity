/**
 * @(#)DocumentosDescargar.java
 *
 *
 * @author
 * @version 1.00 2009/5/18
 */
package saganet.scg;

import javax.servlet.http.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;

public class DocumentoDescargar extends HttpServlet
{

    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);
    }

    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
    	String idDocumento, contentType=null, sql, DRIVER, USERNAME, PASSWORD, STRING, ruta;
    	ServletOutputStream responseOutputStream;
    	byte[] documento=null;
    	Driver dx;
    	Connection cx;
    	PreparedStatement sx;
    	ResultSet rst;
    	boolean documentoEncontrado = false;
    	File archivo;
    	
    	idDocumento = httpServletRequest.getParameter("id_documento");
		responseOutputStream = httpServletResponse.getOutputStream();
		
		try	{
	    	DRIVER = "oracle.jdbc.driver.OracleDriver";
			USERNAME = "scg";
			PASSWORD = "UC32yz5v";
			STRING = "jdbc:oracle:thin:scg/UC32yz5v@localhost:1521:xe";
	
			dx = (Driver)Class.forName(DRIVER).newInstance();
			cx = DriverManager.getConnection(STRING,USERNAME,PASSWORD);
			
			sql = "select archivo, content_type from documentos where id_documento = ?";
			sx = cx.prepareStatement(sql);
			sx.setObject(1,idDocumento,Types.NUMERIC);
			rst = sx.executeQuery();
			if(rst.next())
			{
				documento = rst.getBytes("archivo");
				contentType = rst.getString("content_type");
				
				if(documento!=null)
				{
					//flush it in the response
			        /*
			        httpServletResponse.setHeader("Cache-Control", "no-store");
	    		    httpServletResponse.setHeader("Pragma", "no-cache");
	        		httpServletResponse.setDateHeader("Expires", 0);
			        httpServletResponse.setContentType(contentType);
			        responseOutputStream.write(documento);
	    		    responseOutputStream.flush();
	        		responseOutputStream.close();
	        		*/
	        		documentoEncontrado = true;
				}
			}
			rst.close();
			sx.close();
			cx.close();
			
			InputStream is;
			long length;
			int offset, numRead;
			
			if(!documentoEncontrado){
				ruta = httpServletRequest.getRealPath("/recursos/imagenes/documento_no_disponible.png");
				archivo = new File(ruta);
				contentType = "image/png";
	
				is = new FileInputStream(archivo);
	
	        	// Get the size of the file
		        length = archivo.length();
	
		        // Create the byte array to hold the data
	    	    documento = new byte[(int)length];
	
	        	// Read in the bytes
		        offset = 0;
	    	    numRead = 0;
	        	while (offset < documento.length && (numRead=is.read(documento, offset, documento.length-offset)) >= 0)
	        	{
	            	offset += numRead;
	        	}
	
	        	// Close the input stream and return bytes
	        	is.close();
			}
			
			httpServletResponse.setHeader("Cache-Control", "no-store");
		    httpServletResponse.setHeader("Pragma", "no-cache");
    		httpServletResponse.setDateHeader("Expires", 0);
	        httpServletResponse.setContentType(contentType);
	        responseOutputStream.write(documento);
		    responseOutputStream.flush();
    		responseOutputStream.close();
		}
		catch(Exception e) {
			responseOutputStream.println(e.getMessage());
		}
    }

    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
    	doGet(httpServletRequest,httpServletResponse);
    }
}