package servlets;

import clases.Datos;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;
import javax.sound.midi.MidiSystem;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Rostan on 28/01/2016.
 */
//@WebServlet(name = "ValidarUsuario",urlPatterns = {"/ValidarUsuario","/valUsr"})
@WebServlet(value = "/ValidarUsuario")

public class ValidarUsuario extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Creamos objeto de conexion a la BD
            Datos misDatos = new Datos();
            misDatos.conectar();

            // Tomar los valores del JSP
            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");

            // Validar usuario
            out.println(misDatos.validarUsr(usuario,password));

            // Almacenar el usuario logueado en la sesion
            HttpSession sesion = request.getSession(true);
            sesion.setAttribute("usuario",misDatos.getUsuario(usuario));

            // Cerrar conexion con la BD
            misDatos.desconectar();

        }catch(Exception e){
            out.println("<h1>Error con la BD - Excepcion atrapada "+e.toString()+"</h1>");
        }finally{
            out.close();
        }
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    }
}
