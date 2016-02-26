<%@ page import="clases.Usuario" %>
<%@ page import="clases.Utilidades" %>
<%@ page import="java.util.Date" %>
<%@ page import="clases.Reportes" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="clases.Datos" %><%--
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
        <script>
            $(document).ready(function(){
                $("#fechaInicial").datepicker({
                dateFormat: "yy/mm/dd", changeYear: true
                });

                $("#fechaFinal").datepicker({
                    dateFormat: "yy/mm/dd", changeYear: true
                });
            });
        </script>
    </head>
    <body>
        <% HttpSession sesion = request.getSession();
            Usuario miUsuarioLog = (Usuario)sesion.getAttribute("usuario");
            if (miUsuarioLog == null){ %>
            <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }

            // Variable que muestra los mensajes del sistema.
            String mensaje = "";

            // Identificamos el boton que el usuario presiono.
            boolean generar = false;

            //  Atrapa el valor de la variable en el formulario
            if (request.getParameter("generar") != null) generar= true;

            // Obtenemos el valor como fue llamado el formulario
            String fechaInicial = "";
            String fechaFinal = "";

            if(request.getParameter("fechaInicial") != null) fechaInicial = request.getParameter("fechaInicial");
            if(request.getParameter("fechaFinal") != null) fechaFinal = request.getParameter("fechaFinal");

            if(fechaInicial.equals("")) fechaInicial = Utilidades.formatDate(new Date());
            if(fechaFinal.equals("")) fechaFinal = Utilidades.formatDate(new Date());

            if(generar){

                ResultSet rs = null;
                try {

                    Datos misDatos = new Datos();
                    misDatos.conectar();

                    String sql = "SELECT factura.idFactura,factura.idCliente, CONCAT(nombres,' ',apellidos) AS nombreCompleto,fecha,idLinea,idProducto,descripcion,precio,cantidad,precio*detallefactura.cantidad AS valor " +
                            "FROM factura INNER JOIN clientes ON  clientes.idCliente = factura.idCliente " +
                            "INNER JOIN  detallefactura ON detallefactura.idFactura = factura.idFactura " +
                            "WHERE fecha >= '"+fechaInicial+"' and " +
                            "fecha <= '"+fechaFinal+"'";

                    rs = misDatos.getResultSet(sql);
                    Reportes.reporteFacturas(rs,fechaInicial,fechaFinal);
                    misDatos.desconectar();

                }catch (Exception e){
                    //  Mensaje de error con Reporte de PDF
                }

                %>
                <jsp:forward page="images/Reporte.pdf"></jsp:forward>
                <%
            }
        %>
        <h1>Reporte de facturas</h1>
        <form name="ReporteFacturas" action="ReporteFacturas.jsp" method="POST">
            <table>
                <tbody>
                    <tr>
                        <td>Fecha Inicial:</td>
                        <td><input type="text" name="fechaInicial" id="fechaInicial" value="<%=fechaInicial%>" size="10"/></td>
                    </tr>
                    <tr>
                        <td>Fecha Final:</td>
                        <td><input type="text" name="fechaFinal" id="fechaFinal" value="<%=fechaFinal%>" size="10"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Generar Reporte" name="generar" id="generar"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <br>
        <a href="javascript:history.back(1)">Regresar a la pagina anterior.</a><br>
        <% if (miUsuarioLog.getPerfil() == 1){ %>
            <a href="MenuAdministrador.jsp">Regresar al menu.</a>
        <% }else{ %>
            <a href="MenuEmpleado.jsp">Regresar al menu.</a>
        <% } %>
    </body>
</html>
