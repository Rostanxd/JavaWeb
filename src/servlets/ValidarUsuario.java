package servlets;

import clases.Datos;

import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Rostan on 28/01/2016.
 */
//@WebServlet(name = "ValidarUsuario",urlPatterns = {"/ValidarUsuario","/valUsr"})
@WebServlet(value = "/ValidarUsuario")

public class ValidarUsuario extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<h1>Hola que hace!?</h1>");
        String usr = "zulu";
        String pass = "123";

        try {
            // Creamso objeto de conexion a la BD
            Datos misDatos = new Datos();

            // Tomar los valores del JSP
            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");

//            usr = usuario;
//            pass = password;

            // Validar usuario

            out.println(misDatos.validarUsr(usr,pass) ? "<h1>no ok</h1>" : "<h1>ok/h1>");

//            if (misDatos.validarUsr(usuario,password)){
//                out.println("ok");
//            }else{
//                out.println("no ok");
//            }

            // Cerrar conexion con la BD
            misDatos.desconectar();

        }catch(Exception e){
            out.println(usr+' '+pass);
            out.println("<h1>Error con la BD - Excepcion atrapada"+e.toString()+"</h1>");
        }finally{
            out.close();
        }
    }
}
