<%@ page import="clases.Datos" %>
<%@ page import="clases.Usuario" %>
<%@ page import="clases.Producto" %>
<%@ page import="clases.Utilidades" %>
<%--
  Created by IntelliJ IDEA.
  User: Rostan
  Date: 01/02/2016
  Time: 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <jsp:include page="encabezado.jsp"></jsp:include>
        <title>Sistema de Facturacion</title>
        <script>
            $(document).ready(function(){
                $("#consultar").click(function(){
                    return validarProducto();
                });
            });

            $(document).ready(function(){
                $("#nuevo").click(function(){
                    return validarTodo();
                });
            });

            $(document).ready(function(){
                $("#modificar").click(function(){
                    return validarTodo();
                });
            });

            $(document).ready(function(){
                $("#borrar").click(function(){
                    if (validarProducto()){
                        $("<div></div>").html("Estas seguro de borrar el registro?").
                        dialog({title:"Confirmacion",modal:true,buttons:[
                            {
                                text:"Si",
                                click:function(){
                                    $(this).dialog("close");
                                    $.post("EliminarProducto",{idUsuario:$("#idProducto").val()},function(data){
                                        $("#idProducto").val("");
                                        $("#descripcion").val("");
                                        $("#precio").val("");
                                        $("#idIva").val("");
                                        $("#notas").val("");
                                        $("#foto").val("0");
                                    })
                                }
                            },
                            {
                                text:"No",
                                click:function() {
                                    $(this).dialog("close");
                                }
                            }
                        ]});
                    }
                    return false;
                });
            });

            function validarTodo(){
                if(validarProducto()){
                    if(validarDescripcion()){
                        if(validarPrecio()){
                            return validarIdIva();
                        }
                    }
                }
                return false;
            }

            function validarProducto(){
                if($("#idProducto").val() == ""){
                    $("<div></div>").html("Debe ingesar un Id de Producto.").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarDescripcion(){
                if($("#descripcion").val() == ""){
                    $("<div></div>").html("Debe ingesar una descripcion para el producto.").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarPrecio(){
                if($("#precio").val() == ""){
                    $("<div></div>").html("Debe ingesar el precio del Producto.").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarIdIva(){
                if($("#idIva").val() == ""){
                    $("<div></div>").html("Debe ingesar el Id. IVA del Producto.").dialog({
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
        <% HttpSession sesion = request.getSession();
            Usuario miUsuarioLog = (Usuario)sesion.getAttribute("usuario");
            if (miUsuarioLog == null){ %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <% } if (miUsuarioLog.getPerfil() != 1){ %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <% } %>
        <%
            // Variable que muestra los mensajes del sistema.
            String mensaje = "";

            // Identificamos el boton que el usuario presiono.
            boolean consultar = false;
            boolean nuevo = false;
            boolean modificar = false;
            boolean borrar = false;
            boolean limpiar = false;
            boolean listar = false;

            if (request.getParameter("consultar") != null) consultar = true;
            if (request.getParameter("nuevo") != null) nuevo = true;
            if (request.getParameter("modificar") != null) modificar = true;
            if (request.getParameter("borrar") != null) borrar = true;
            if (request.getParameter("limpiar") != null) limpiar = true;
            if (request.getParameter("listar") != null) listar = true;

            // Obtenemos el valor como fue llamado el formulario.
            String idProducto = "";
            String descripcion = "";
            String precio = "";
            String idIva = "";
            String notas = "";
            String foto = "";

            if(request.getParameter("idProducto") != null) idProducto = request.getParameter("idProducto");
            if(request.getParameter("descripcion") != null) descripcion = request.getParameter("descripcion");
            if(request.getParameter("precio") != null) precio = request.getParameter("precio");
            if(request.getParameter("idIva") != null) idIva = request.getParameter("idIva");
            if(request.getParameter("notas") != null) notas = request.getParameter("notas");
            if(request.getParameter("fotos") != null) foto = request.getParameter("fotos");

            // Si presiona el boton consultar
            if (consultar){
                Datos misDatos = new Datos();
                misDatos.conectar();
                Producto miProducto = misDatos.getproducto(idProducto);
                if(miProducto==null){
                    mensaje = "Producto no existe o error con la BD.";
                    idProducto = "";
                    descripcion = "";
                    precio = "";
                    idIva = "";
                    notas = "";
                    foto = "";
                }else{
                    idProducto = miProducto.getIdProducto();
                    descripcion = miProducto.getDescripcion();
                    precio = ""+miProducto.getPrecio();
                    idIva = ""+miProducto.getIdIva();
                    notas = miProducto.getNotas();
                    foto = miProducto.getFoto();
                    mensaje = "Producto consultado";
                }
                misDatos.desconectar();
            }

            // Para limpiar el formulario
            if(limpiar){
                mensaje = "";
                idProducto = "";
                descripcion = "";
                precio = "";
                idIva = "";
                notas = "";
                foto = "";
            }

            // Si presiona boton Nuevo
            if(nuevo) {
                if (!Utilidades.isNumeric(precio)) {
                    mensaje = "Debe Ingresar un valor numerico en el precio.";
                } else if(Utilidades.stringToInt(precio) <= 0){
                    mensaje = "Debe ingresar un valor mayor a cero.";
                } else {
                    Datos misDatos = new Datos();
                    misDatos.conectar();
                    Producto miProducto = misDatos.getproducto(idProducto);
                    if (miProducto != null) {
                        mensaje = "Producto ya existe";
                    } else {
                        miProducto = new Producto(idProducto,
                                descripcion,
                                new Integer(precio),
                                new Integer(idIva),
                                notas,
                                foto);
                        misDatos.newProducto(miProducto);
                        mensaje = "Producto ingresado.";
                    }
                    misDatos.desconectar();
                }
            }

            // Si presiona boton Modificar
            if(modificar){
                if(!Utilidades.isNumeric(precio)) {
                    mensaje = "Debe ingresar un valor numerico en el precio.";
                }else if(Utilidades.stringToInt(precio) <= 0){
                    mensaje = "Debe ingresar un valor mayor a cero";
                }else{
                    Datos misDatos = new Datos();
                    misDatos.conectar();
                    Producto miProducto = misDatos.getproducto(idProducto);
                    if (miProducto == null) {
                        mensaje = "Producto no existe";
                    } else {
                        miProducto = new Producto(idProducto,
                                descripcion,
                                new Integer(precio),
                                new Integer(idIva),
                                notas,
                                foto);
                        misDatos.updateProducto(miProducto);
                        mensaje = "Producto modificado.";
                    }
                    misDatos.desconectar();
                }
            }

            // Si presiona el boton borrar
            // Esto esta considerado en el jQuery del comienzo.

            // Si presiona Listar
            if(listar){
                %>
                    <jsp:forward page="ListadoProductos.jsp"></jsp:forward>
                <%
            }
        %>
        <h1>Productos</h1>
        <form name = "Productos" id = "Productos" action = "Productos.jsp" method = "POST">
            <table>
                <tr>
                    <td>Id. Producto*:</td>
                    <td><input type="text" name="idProducto" id="idProducto" value="<%=idProducto%>" size="12"/></td>
                </tr>
                <tr>
                    <td>Descirpcion*:</td>
                    <td><input type="text" name="descripcion" id="descripcion" value="<%=descripcion%>" size="50"/></td>
                </tr>
                <tr>
                    <td>precio*:</td>
                    <td><input type="text" name="precio" id="precio" value="<%=precio%>" size="11"/></td>
                </tr>
                <tr>
                    <td>IVA*:</td>
                    <td><select name="idiva" id="idIva">
                        <option value="0" <%=(idIva.equals("") ? "selected" : "")%>>Seleccione una tarifa...</option>
                        <option value="1" <%=(idIva.equals("1") ? "selected" : "")%>>0%</option>
                        <option value="2" <%=(idIva.equals("2") ? "selected" : "")%>>10%</option>
                        <option value="3" <%=(idIva.equals("3") ? "selected" : "")%>>12</option>
                    </select></td>
                </tr>
                <tr>
                    <td>Notas:</td>
                    <td><textarea name="notas" id="notas" rows="4" cols="50"><%=notas%></textarea></td>
                </tr>
                <tr>
                    <td>Foto:</td>
                    <td>
                        <input type="file" name="foto" value="" id="foto" value="<%=foto%>"/>
                        <% if (foto.isEmpty()){
                            foto = "";
                        }
                            if (foto != ""){ %>
                        <br>
                        <img style="height: 150px; width: 150px;" src=<%="images/"+foto%>>
                        <% }else{ %>
                        <br>
                        <img style="height: 150px; width: 150px;" src="images/product01.png">
                        <% } %>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">*Campos obligatorios</td>
                </tr>
            </table>
            <br>
            <jsp:include page="botones.jsp"></jsp:include>
        </form>
        <br>
        <h1 style="color:white"><%=mensaje%></h1>
        <br>
        <a href="javascript:history.back(1)">Regresar a la pagina anterior</a><br>
        <a href="MenuAdministrador.jsp">Regresar al menu</a>
    </body>
</html>
