<%@ page import="clases.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 28/01/2016
  Time: 0:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="encabezado.jsp"></jsp:include>
        <title>Sistema de Facturacion</title>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            Usuario miUsuario = (Usuario)sesion.getAttribute("usuario");
            if (miUsuario == null){
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
            if (miUsuario.getPerfil() != 2){
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
        %>
        <h1>Menu Principal</h1>
        <h2>Bienvenido... <%=miUsuario.getNombres()+" "+miUsuario.getApellidos()%></h2>
        <br>
        <% String foto = miUsuario.getFoto();
            if (foto.isEmpty()){
                foto = "";
            }
            if (foto != ""){ %>
        <img style="height: 100px; width: 100px;" src=<%="images/"+foto%>>
        <% }else{ %>
        <img style="height: 100px; width: 100px;" src="images/noImagen.png">
        <% } %>
        <br><br><br><br>
        <a href="ReporteFacturas.jsp">Reporte Facturas</a><br>
        <a href="index.jsp">Salir</a>
    </body>
</html>
