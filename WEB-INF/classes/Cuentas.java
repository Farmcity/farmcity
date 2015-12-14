/**
 * @(#)Cuentas.java
 *
 *
 * @author 
 * @version 1.00 2014/4/13
 */
package saganet.scg;

import java.util.StringTokenizer;

public class Cuentas {

    public Cuentas() {
    }
    
    public static int getNivel(String idCuenta){
    	int nivel;
    	StringTokenizer tokens;
    	
    	tokens = new StringTokenizer(idCuenta, ".");
    	nivel = tokens.countTokens();
    	
    	return nivel;    	
    }
}