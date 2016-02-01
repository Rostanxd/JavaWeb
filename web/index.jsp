<%--
  Created by IntelliJ IDEA.
  User: RoStan
  Date: 27/01/2016
  Time: 20:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <jsp:include page="encabezado.jsp"></jsp:include>
    <title>Aplicacion WEB</title>
  </head>
  <body>
    <h1>Ingreso al Sistema !!</h1>
    <form name="ValidarUsuario" id="ValidarUsuario" action="ValidarUsuario" method="post">
      <table border="0">
        <tbody>
          <tr>
            <td>Usuario:</td>
            <td><input type="text" name="usuario" id="usuario" value="" size="10"/></td>
          </tr>
          <tr>
            <td>Clave:</td>
            <td><input type="password" name="password" id="password" value="" size="10"/></td>
          </tr>
          <tr>
            <td colspan="2"><input  type="submit" value="Ingresar" name="Ingresar" id="Ingresar"/></td>
          </tr>
        </tbody>
      </table>
    </form>
  </body>
</html>
