/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Persistencia.ConexionBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Windows 10
 */
public class Paciente {
    private String nombres;
    private String apellidos;
    private int identificacion_paciente;
    private String direccion;
    private String telefono;
    private String tipo_identificacion;
    private String genero;
    private int edad;

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public int getIdentificacion_paciente() {
        return identificacion_paciente;
    }

    public void setIdentificacion_paciente(int identificacion_paciente) {
        this.identificacion_paciente = identificacion_paciente;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getTipo_identificacion() {
        return tipo_identificacion;
    }

    public void setTipo_identificacion(String tipo_identificacion) {
        this.tipo_identificacion = tipo_identificacion;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }


    public void llenarPaciente(int identificacion_paciente, String tipo_identificacion, String nombres, String apellidos, String genero, int edad, String direccion, String telefono){
        this.identificacion_paciente = identificacion_paciente;
        this.tipo_identificacion = tipo_identificacion;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.direccion = direccion;
        this.telefono = telefono;
        this.genero = genero;
        this.edad = edad;
          
    }
    
    //Métodos CRUD -----------
    public boolean guardarPaciente(){
        ConexionBD conexion = new ConexionBD ();
        String sentencia = "INSERT INTO paciente (identificacion,"
                + "tipoIdentificacion, nombres, apellidos, genero, edad, direccion,"
                + "telefono) VALUES ('"+this.identificacion_paciente+"'"
                + "'"+this.tipo_identificacion+"','"+this.nombres+"','"+this.apellidos+"'"
                + "'"+this.genero+"','"+this.edad+"','"+this.direccion+"', '"+this.telefono+"')";
        if(conexion.setAutoCommit(false)){
            //Si logra enviar la sentencia y llamar a insertar
            //Permitir ejecutar la sentencia en el método
            if(conexion.insertarBD(sentencia)){
                conexion.commitBD();
                conexion.cerrarConnection();
                return true;
            }else{
                //Si no logra hacerlo
                conexion.rollbrackBD();
                conexion.cerrarConnection();
                return false;
            }
            
        }else{ 
            conexion.cerrarConnection();
            return false;
        }
    }
    
    public boolean borrarPaciente(int identificacion){
        ConexionBD conexion = new ConexionBD();
        String sentencia = "DELETE FROM paciente WHERE identificacion ='"+identificacion+"'";
        if(conexion.setAutoCommit(false)){
            //Si logra enviar la sentencia y llamar al método
            //Permitir ejecutar la sentencia en el método
            if(conexion.acualizarBD(sentencia)){
                conexion.commitBD();
                conexion.cerrarConnection();
                return true;
                
            }else{
                conexion.rollbrackBD();
                conexion.cerrarConnection();
                return false;
            }
        }else{
            conexion.cerrarConnection();
            return false;      
        }
    }
    
    public boolean actualizarPaciente(){
        ConexionBD conexion = new ConexionBD();
        String sentencia = "UPDATE paciente SET identificacion ='"+this.identificacion_paciente+"',"
                + "'"+this.tipo_identificacion+"'"
                + "'"+this.nombres+"', '"+this.apellidos+"','"+this.genero+"','"+this.edad+"','"+this.direccion+"',"
                + "'"+this.telefono+"'";
        if(conexion.setAutoCommit(false)){
            if(conexion.acualizarBD(sentencia)){
                conexion.commitBD();
                conexion.cerrarConnection();
                return true;
            }else{
                conexion.rollbrackBD();
                conexion.cerrarConnection();
                return false;
            }      
        }else{
            conexion.cerrarConnection();
            return false;
            
        }
    }
    
    public List<Paciente> listarPaciente() throws SQLException{
        ConexionBD conexion = new ConexionBD();
        List<Paciente> listaPacientes = new ArrayList<>();
        String sentencia = "SELECT * FROM paciente ORDER BY nombres ASC";
        ResultSet rs = conexion.consultarBD(sentencia);
        Paciente p;
        while(rs.next()){
            p = new Paciente();
            p.setIdentificacion_paciente(rs.getInt("identificacion_paciente"));
            p.setTipo_identificacion(rs.getString("tipo_identificacion"));
            p.setNombres(rs.getString("nombres"));
            p.setApellidos(rs.getString("apellidos"));
            p.setGenero(rs.getString("genero"));
            p.setEdad(rs.getInt("edad"));
            p.setDireccion(rs.getString("direccion"));
            p.setTelefono(rs.getString("telefono"));
            listaPacientes.add(p);
        }
        conexion.cerrarConnection();
        return listaPacientes;
           
    }

    @Override
    public String toString() {
        return "Paciente{" + "nombres=" + nombres + ", apellidos=" + apellidos + ", identificacion_paciente=" + identificacion_paciente + ", direccion=" + direccion + ", telefono=" + telefono + ", tipo_identificacion=" + tipo_identificacion + ", genero=" + genero + ", edad=" + edad + '}';
    }
  
}
