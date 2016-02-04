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
    <script>
      $(document).ready(function() {
        $("#ValidarUsuario").submit(function(){
          $.post("ValidarUsuario",$("#ValidarUsuario").serialize(),function(data){
            perfil = jQuery.trim(data);
            if(perfil == 1) document.location.href = "MenuAdministrador.jsp";
            else if(perfil == 2) document.location.href = "MenuEmpleado.jsp";
            else $("#mensaje-ingreso").html("<h1>Usuario o Clave no validos.</h1>")
          });
          return false;
        });
      });
    </script>
  </head>
  <body>
    <%
      session.invalidate();
    %>
    <h1>Ingreso al Sistema !!</h1>
    <form name="ValidarUsuario" id="ValidarUsuario" action="ValidarUsuario" method="POST">
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
    <div id="mensaje-ingreso"></div>
  </body>
</html>
