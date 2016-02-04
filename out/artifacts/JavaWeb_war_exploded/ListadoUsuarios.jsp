<%@ page import="clases.Datos" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="clases.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: Bairon
  Date: 03/02/2016
  Time: 13:35
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
        <% } if (miUsuarioLog.getPerfil() != 1){ %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <% } %>
        <h1>Listado de Usuarios</h1>
        <table>
            <thead>
                <tr>
                    <th>Id Usuario</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Perfil</th>
                    <th>Foto</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Datos misDatos = new Datos();
                    misDatos.conectar();
                    ResultSet rs = misDatos.getUsuarios();
                    while(rs.next()){
                %>
                    <tr>
                        <td><%=rs.getString("idUsuario")%></td>
                        <td><%=rs.getString("nombres")%></td>
                        <td><%=rs.getString("apellidos")%></td>
                        <td><%=(rs.getString("idPerfil").equals("1")?"Administrador":"Empleado")%></td>
                        <td>
                            <% String foto = rs.getString("foto");
                                if (foto.isEmpty()){
                                    foto = "";
                                }
                                if (foto != ""){
                            %>
                                <img style="height: 100px; width: 80px;" src=<%="images/"+foto%>>
                            <% }else{ %>
                                <img style="height: 100px; width: 80px;" src="images/noImagen.png">
                            <% } %>
                        </td>
                    </tr>
                <%
                    }
                    misDatos.desconectar();
                %>
            </tbody>
        </table>
        <a href="javascript:history.back(1)">Regresar a la pagina anterior</a><br>
        <a href="MenuAdministrador.jsp">Regresar al menu</a>
    </body>
</html>
