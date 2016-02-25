<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Date" %>
<%@ page import="clases.*" %><%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 22/02/2016
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="encabezado.jsp"></jsp:include>
    <title>Sistema de Facturacion</title>
    <script>
        $(document).ready(function(){
            $("#adicionar").click(function(){
                return validarAdicionar();
            });
        });

        $(document).ready(function(){
            $(".eliminar").click(function(){
                $("#borrado").val($(this).attr("href"));
                $("<div></div>").html("Esta seguro de querer borrar el producto "
                        +$("#borrado").val()+ " ?.").dialog({
                    title:"Confirmacion",
                    modal:true,
                    buttons: [{
                        text: "Si",
                        click:function(){
                            $(this).dialog("close");
                            $.post("EliminarDetalleFacturaTmp",
                                    {idProducto:$("#borrado").val()},
                                    function(data){
                                        location.reload();
                                        $("#cantidad").val("123");
                                        $("#producto").val("1");
                                    })
                        }
                    },
                        {
                            text: "No",
                            click:function(){
                                $(this).dialog("close");
                            }
                        }
                    ]});
                return false;
            });
        });

        function validarAdicionar(){
            if(validarProducto()){
                return validarCantidad();
            }
            return false;
        }

        function validarProducto(){
            if($("#producto").val() == 0){
                $("<div></div>").html("Debe seleccionar un producto.").dialog({
                    title:"Error de validacion",modal:true,
                    buttons:[{text:"Ok",click:function(){
                        $(this).dialog("close");
                    }}]
                });
                return false;
            }
            return true;
        };

        function validarCantidad(){
            if($("#cantidad").val() == ""){
                $("<div></div>").html("Debe ingresar un valor en cantidad.").dialog({
                    title:"Error de validacion",modal:true,
                    buttons:[{text:"Ok",click:function(){
                        $(this).dialog("close");
                    }}]
                });
                return false;
            }
            return true;
        };

    </script>
</head>
<body>
    <%
        HttpSession sesion = request.getSession();
        Usuario miUsuarioLog = (Usuario)sesion.getAttribute("usuario");
        if (miUsuarioLog == null){ %>
        <jsp:forward page="index.jsp"></jsp:forward>
            <% } if (miUsuarioLog.getPerfil() != 1){ %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <% } %>
    <%
        // Variable que muestra los mensajes del sistema.
        String mensaje = "";

        // Abrimos conexion con la base de datos
        Datos misDatos = new Datos();
        misDatos.conectar();

        ResultSet clientes = misDatos.getClientes();
        ResultSet productos = misDatos.getProductos();

        // Botones
        boolean adicionar = false;
        boolean grabar = false;

        if(request.getParameter("adicionar") != null){
            adicionar = true;
        };
        if(request.getParameter("grabar") != null){
            grabar = true;
        };

        // Obtenemos el valor como fue llamado el formulario.
        String fecha = Utilidades.formatDate(new Date());
        String cliente = "";
        String producto = "";
        String cantidad = "";

        if(request.getParameter("cliente") != null) cliente = request.getParameter("cliente");
        if(request.getParameter("producto") != null) producto = request.getParameter("producto");
        if(request.getParameter("cantidad") != null) cantidad = request.getParameter("cantidad");

        // Si presionan el boton de agregar
        if(adicionar){
            if(producto.equals(0)){
                mensaje = "Debe seleccionar un producto.";
            }else if(cantidad.isEmpty()){
                mensaje = "Debe ingresar una cantidad.";
            }else if(!Utilidades.isNumeric(cantidad)){
                mensaje = "Debe ingresar un valor numerico";
            }else if(Utilidades.stringToInt(cantidad) <= 0){
                mensaje = "La cantidad debe ser mayor a cero '0'";
            }else{
                // Buscamos producto en la bd
                Producto miProducto = misDatos.getproducto(producto);

                // Crear el objeto de nuevo detalle.
                DetalleFacturaTmp miDetale = new DetalleFacturaTmp(
                        miProducto.getIdProducto(),
                        miProducto.getDescripcion(),
                        miProducto.getPrecio(),
                        new Integer(cantidad));

                //  Adicionamos el detalle
                misDatos.newDetalleFacturaRmp(miDetale);

                // Inicializamos  variables y colocamos mensajes.
                producto = "";
                cantidad = "";
                mensaje = "Producto agregado.";
            }

        }

//        misDatos.desconectar(); // nunca cerrar la base de datos al comienzo, hacerlo al final.
    %>

    <h1>Nueva Factura</h1>
    <form name="nuevaFactura" id="nuevaFactura" action="NuevaFactura.jsp" method="POST">
        <table>
            <tr>
                <td>Fecha:</td>
                <td coslpan="3"><input type="text" name="fecha" id="fecha" value="<%=fecha%>" size="10" disabled="disabled"/></td>
            </tr>
            <tr>
                <td>Cliente</td>
                <td colspan="3">
                    <select name="cliente" id="cliente">
                        <option value="0">Seleccione un cliente...</option>
                        <%
                            while(clientes.next()){
                        %>

                        <option value="<%=clientes.getString("idCliente")%>"
                        <%=(clientes.getString("idCliente").equals(cliente) ? "selected" : "")%>>
                        <%=clientes.getString("nombres")+clientes.getString("apellidos")%></option>

                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Producto</td>
                <td colspan="3">
                    <select name="producto" id="producto">
                        <option value="0">Seleccione un producto...</option>
                        <%
                            while(productos.next()){
                                %>
                            <option value=<%=productos.getString("idProducto")%>
                            <%=(productos.getString("idProducto").equals(producto) ? "selected" : "")%>
                            ><%=productos.getString("descripcion")%></option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Cantidad</td>
                <td><input type="text" name="cantidad" id="cantidad" value="" size="10"/></td>
                <td><input type="submit" name="adicionar" id="adicionar" value="Adicionar"/></td>
                <td><input type="submit" name="grabar" id="grabar" value="Grabar Factura"></td>
            </tr>
            <tr>
                <td colspan="4" name="mensaje" id="mensaje"><h2><%=mensaje%></h2></td>
            </tr>
        </table>
        <br>
        <table border="1">
            <thead>
                <tr align="center">
                    <td>Eliminar</td>
                    <td>Id. Producto</td>
                    <td>Descripcion</td>
                    <td>Precio</td>
                    <td>Cantidad</td>
                    <td>Valor</td>
                </tr>
            </thead>
            <tbody>

            <%
                ResultSet detalle = misDatos.getDetalleFacturaTmp();
                while(detalle.next()){
            %>
                <tr>
                    <td align="center"><a href="<%=detalle.getString("idProducto")%>" class="eliminar"><img style="height: 16px; width: 16px;" src="delete-icon.png"></a></td>
                    <td><%=detalle.getString("idProducto")%></td>
                    <td><%=detalle.getString("descripcion")%></td>
                    <td align="right"><%=detalle.getInt("precio")%></td>
                    <td align="right"><%=detalle.getInt("cantidad")%></td>
                    <td align="right"><%=detalle.getInt("precio")*detalle.getInt("cantidad")%></td>
                </tr>
            <%
                }
            %>
                <tr>
                    <td align="right" colspan="4">TOTAL</td>
                    <td align="right"><%=misDatos.getTotalCantidad()%></td>
                    <td align="right"><%=misDatos.getTotalValor()%></td>
                </tr>
            </tbody>
        </table>
    </form>
    <br>
    <%
        misDatos.desconectar();
    %>
    <a href="javascript:history.back(1)">Regresar a la pagina anterior</a><br>
    <a href="MenuAdministrador.jsp">Regresar al menu</a>
    <input type="hidden" id="borrado"/>
</body>
</html>
