package sibp;
 
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class Utilidades {

    public Utilidades() {
    }
    
    public static StringBuilder genJSON(ResultSet rst) throws SQLException{
    	ResultSetMetaData rstMD;
    	int i, j;
    	StringBuilder dataSource;
    	String auxAnterior, template;
    	
    	rstMD = rst.getMetaData();
    	j = rstMD.getColumnCount();
    	System.out.println(j);
    	
    	dataSource = new StringBuilder();
    	template = ", '@1':'@2'";
    	dataSource.append("[");
    	auxAnterior = "";
    	while(rst.next()){
    		dataSource.append(auxAnterior);
    		dataSource.append("{'id':'");
    		dataSource.append(rst.getString(1));
    		dataSource.append("'");
	    	for(i=1;i<j;i++){
	    		//System.out.println (rstMD.getColumnName(i));
	    		//System.out.println (rst.getString(i)==null?"":rst.getString(i));
	    		dataSource.append(template.replaceFirst("@1",rstMD.getColumnName(i).toLowerCase()).replaceFirst("@2",rst.getString(i)==null?"":rst.getString(i)));
	    		//dataSource += auxAnterior + "{'id':'"+rst.getString("id_banco")+"', 'id_banco':'"+rst.getString("id_banco")+"', 'nombre':'"+rst.getString("nombre")+"', 'id_cuenta':'"+rst.getString("id_cuenta")+"', 'id_banco_padre':'"+rst.getString("id_banco_padre")+"', 'id_oficina':'"+rst.getString("id_oficina")+"'}";
	    	}
	    	dataSource.append("}");
	    	auxAnterior = ", ";
    	}
    	dataSource.append("]");
    	
    	return dataSource;
    }
    
    public static void main (String[] args) throws Exception{
    	java.sql.Driver dx = (java.sql.Driver)Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
		java.sql.Connection cx = java.sql.DriverManager.getConnection("jdbc:oracle:thin:scg/UC32yz5v@developer.saganet.com.mx:1521:xe", "scg", "UC32yz5v");
		java.sql.PreparedStatement sx;
		ResultSet rst;
		String sql;
		StringBuilder json;
		
		sql = "select * from bancos order by id_banco";
		sx = cx.prepareStatement(sql);
		rst = sx.executeQuery();
		json = saganet.scg.Utilidades.genJSON(rst);
		System.out.println(json.toString());
		rst.close();
		sx.close();
		cx.close();
    }
}