/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Persistencia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Windows 10
 */
public class ConexionBD {
    
    //Variables de configuración de la BD
    private String BD_driver = "";
    private String url = "";
    private String bd = "";
    private String host = "";
    private String username = "";
    private String password = "";
    //Conexión 
    private Connection conn = null;
    //Ejecutar las sentencias de la BD
    private Statement stmt = null;
    //Preparar y conectar con la conexión y con sql
    private PreparedStatement pstmt = null;
    //Guarga una tabla, filas y columnas
    private ResultSet rs = null;
    
    //Constructor
    public ConexionBD(){
        //Está en internet
        BD_driver = "com.mysql.jdbc.Driver";
        //Puerto al final
        host = "localhost:3306";
        bd = "consultorio_online_2";
        //jdbc:mysql://...
        url = "jdbc:mysql://"+host +"/"+bd;
        username = "root";
        password = "";
        
        try{
            //Asignación del Driver
            Class.forName(BD_driver);
        }catch(ClassNotFoundException ex){
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null,ex);    
        }
        try{
            //Realizar la conexión
            conn = DriverManager.getConnection(url, username, password);
            conn.setTransactionIsolation(8);
        }catch (SQLException ex){
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null,ex);    
        
        }
    }
    
    //Método para retornar la conexión
    public Connection getConnection(){
        return conn;
    } 
    //Método para cerrar la conexión
    public void closeConnection(Connection conn){
        if (conn !=null){
            try{
                conn.close();
            }catch (SQLException ex){
                Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE,null,ex);
            }
        }
    }
    
    //Insertar ----------- SELECT
    public boolean insertarBD(String sentencia){
        try{
                stmt = conn.createStatement();
                stmt.execute(sentencia);
        }catch (SQLException | RuntimeException sqlex){
                System.out.println("Error rutina: "+sqlex);
                return false;
        }
        return true;
    }
    //Método que devuelve un ResultSet de una consulta
    //consultar -------------
    public ResultSet consultarBD(String sentencia){
        try{
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(sentencia);
        }catch(SQLException sqlex){
            System.out.println("Error en la consulta");
        } 
        return rs;
    }
    
    //Eliminar --------------
    public boolean borrarBD(String sentencia){
        try{
            stmt = conn.createStatement();
            stmt.execute(sentencia);
        }catch(SQLException | RuntimeException sqlex){
            System.out.println("Error al eliminar: "+sqlex);
            return false;
        }
        return true;
    }
    
    //Actualizar -----------
    public boolean acualizarBD(String sentencia){
        try{
            stmt = conn.createStatement();
            stmt.executeUpdate(sentencia);
            
        }catch(SQLException | RuntimeException sqlex){
            System.out.println("Error al actualizar: "+sqlex);
            return false;
        }
        return true;
    }
    
    //-------------------------------------------
    //Método AutoCommit
    public boolean setAutoCommit(boolean parametro){
        try{
            conn.setAutoCommit(parametro);
        }catch(SQLException sqlex){
            System.out.println("Error al configurar el autoCommit: "+sqlex.getMessage());
            return false;
        }
        return true;
    }
    
    //Cerrar bien la conexión
    public void cerrarConnection(){
        closeConnection(conn);
    }
    
    public boolean commitBD(){
        try{
            conn.commit();
            return true;
        }catch (SQLException sqlex){
            System.out.println("Error al hacer el commit: "+sqlex.getMessage());
            return false;
        }
    }
    
    public boolean rollbrackBD(){
        try{
            conn.rollback();
            return true;
        }catch(SQLException sqlex){
            System.out.println("Error al hacer un rollback: "+sqlex.getMessage());
        }   return false;
    }
    
    public static void main(String [] args){
        ConexionBD b = new ConexionBD();
        b.cerrarConnection();
    }
    
}
