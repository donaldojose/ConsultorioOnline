<%-- 
    Document   : Peticiones
    Created on : 27/09/2021, 06:22:37 PM
    Author     : Windows 10
--%>


<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level" %>
<%@page import="java.sql.SQLException" %>
<%@page import="Logica.Paciente" %>
<%@page import="com.google.gson.Gson" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Arrays" %>
<%@page import="java.util.List" %>

<%@page contentType="application/json;charset=iso-8859-1" pageEncoding="iso-8859-1" session="true"%>

<%
    //Iniciando respuesta Json
    String respuesta = "{";
        List<String> tareas = Arrays.asList(new String[]{
            "actualizarPaciente",
            "eliminarPaciente",
            "listarPaciente",
            "guardarPaciente",
        });
        
        String proceso = "" +request.getParameter("proceso");
        Paciente p = new Paciente();
        
        //Validación de parámetros
        if(tareas.contains(proceso)){
            
            //-------inicio de procesos-----------
        
            if(proceso.equals("guardarPaciente")){
                int ident = Integer.parseInt(request.getParameter("identificacion_paciente"));
                String tipoIdent = request.getParameter("tipo_identificacion");
                String nombres = request.getParameter("nombres");
                String apellidos = request.getParameter("apellidos");
                String genero = request.getParameter("genero");
                int edad = Integer.parseInt(request.getParameter("edad"));
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                
                p.llenarPaciente(ident, tipoIdent, nombres, apellidos, genero, edad, direccion, telefono);
                if(p.guardarPaciente()){
                    respuesta += "\"" + proceso + "\" : true";
                    
                }else{
                    respuesta += "\"" + proceso + "\" : false";
                }
                    
            }else if(proceso.equals("eliminarPaciente")){
                int identificacion = Integer.parseInt(request.getParameter("identificacion"));
                if(p.borrarPaciente(identificacion)){
                    respuesta += "\"" + proceso + "\" : true";

                }else{
                    respuesta += "\"" + proceso + "\" : true";
                   
                }
            }else if(proceso.equals("listarPaciente")){
                try {
                       List<Paciente> lista = p.listarPaciente();
                       respuesta += "\"" + proceso + "\": true,\"Pacientes\":" + new Gson().toJson(lista);
                     
                    } catch (SQLException ex) {
                        respuesta += "\"" + proceso + "\": true,\"Pacientes\" : []";
                        Logger.getLogger(Paciente.class.getName()).log(Level.SEVERE, null, ex);
                        
                    }
            }else if(proceso.equals("actualizarPaciente")){
                int ident = Integer.parseInt(request.getParameter("identificacion"));
                String tipoIdent = request.getParameter("tipoIdentificacion");
                String nombres = request.getParameter("nombre");
                String apellidos = request.getParameter("apellido");
                String genero = request.getParameter("genero");
                int edad = Integer.parseInt(request.getParameter("edad"));
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                //boolean favorito = Boolean.parseBoolean(request.getParameter("favorito"));
                
                p.llenarPaciente(ident, tipoIdent, nombres, apellidos, genero, edad, direccion, telefono);
                
                if(p.actualizarPaciente()){
                    respuesta += "\"" + proceso + "\": true";
                }else{
                    respuesta += "\"" + proceso + "\": false";
                    
                }
                
            }
                
            //------------------------------------
        
        }else{
            respuesta += "\"ok\" : false,";
            respuesta += "\"ERROR\": \"INVÁLIDO\",";
            respuesta += "\"ErrorMsg\" : \"Lo sentimos, los datos que ha enviado,"
                    + "son inválidos. Por favor corríjalos y vuelve a intentar";
            
        }
    
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);


%>