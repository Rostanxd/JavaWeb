<%@ page import="clases.Datos" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="clases.Usuario" %>
<%@ page import="clases.Utilidades" %><%--
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
        <h1>Listado de Clientes</h1>
        <table>
            <thead>
                <tr>
                    <th>Id Cliente</th>
                    <th>Tipo</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Direccion</th>
                    <th>Telefono</th>
                    <th>Ciudad</th>
                    <th>Fecha Nacimiento</th>
                    <th>Fecha Ingreso</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Datos misDatos = new Datos();
                    misDatos.conectar();
                    ResultSet rs = misDatos.getClientes();
                    while(rs.next()){
                %>
                    <tr>
                        <td><%=rs.getString("idCliente")%></td>
                        <td><%=Utilidades.Tipo(rs.getInt("idTipo"))%></td>
                        <td><%=rs.getString("nombres")%></td>
                        <td><%=rs.getString("apellidos")%></td>
                        <td><%=rs.getString("direccion")%></td>
                        <td><%=rs.getString("telefono")%></td>
                        <td><%=Utilidades.Ciudad(rs.getInt("idCiudad"))%></td>
                        <td><%=rs.getString("fechaNacimiento")%></td>
                        <td><%=rs.getString("fechaIngreso")%></td>
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
