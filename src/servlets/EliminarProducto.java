package servlets;

import clases.Datos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Rostan on 03/02/2016.
 */
@WebServlet(name = "EliminarUsuario")
public class EliminarProducto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            Datos misDatos = new Datos();
            misDatos.conectar();
            misDatos.deleteProducto(request.getParameter("idProducto"));
            misDatos.desconectar();
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            out.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
