<%@ page import="clases.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: Bairon
  Date: 03/02/2016
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <jsp:include page="encabezado.jsp"></jsp:include>
        <title>Sistema de Facturacion</title>
    </head>
    <body>
        <% HttpSession sesion = request.getSession();
            Usuario miUsuarioLog = (Usuario)sesion.getAttribute("usuario");
            if (miUsuarioLog == null){ %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <% } %>
        <h1>Reporte de facturas</h1>
        <br>
        <a href="javascript:history.back(1)">Regresar a la pagina anterior.</a><br>
        <% if (miUsuarioLog.getPerfil() == 1){ %>
            <a href="MenuAdministrador.jsp">Regresar al menu.</a>
        <% }else{ %>
            <a href="MenuEmpleado.jsp">Regresar al menu.</a>
        <% } %>
    </body>
</html>
