package sibp;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class Configuraciones {
    public Configuraciones() {
    }
    public static String getEntidades(int idEntidad){
        String entidad=new String("");
        String[] arregloEntidades={"aguascalientes","baja_california","baja_california_sur","campeche","coahuila","colima","chiapas","chihuahua","distrito_federal","durango","guanajuato","guerrero","hidalgo","jalisco","mexico","michoacan","morelos","nayarit","nuevo_leon","oaxaca","puebla","queretaro","quintana_roo","san_luis_potosi","sinaloa","sonora","tabasco","tamaulipas","tlaxcala","veracruz","yucatan","zacatecas"};
        entidad=arregloEntidades[idEntidad-1];
        return entidad;
    }
    public static void main(String []args){
        System.out.println("Tabla: "+getEntidades(13));
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
}