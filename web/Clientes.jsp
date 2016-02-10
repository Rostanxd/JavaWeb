<%@ page import="clases.Datos" %>
<%@ page import="clases.Usuario" %>
<%@ page import="clases.Cliente" %>
<%@ page import="clases.Utilidades" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Rostan
  Date: 09/02/2016
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
                    return validarCliente();
                });
            });

            $(document).ready(function(){
                $("#nuevo").click(function(){
                    return validarTodo();
                });
            });

            $(document).ready(function(){
                $("#modificar").click(function(){
                    return validarCliente();
                });
            });

            $(document).ready(function(){
               $("#fechaNacimiento").datepicker({
                   dateFormat: "yy/mm/dd", changeYear: true
               });
            });

            $(document).ready(function(){
                $("#borrar").click(function(){
                    if (validarCliente()){
                        $("<div></div>").html("Estas seguro de borrar el registro?").
                        dialog({title:"Confirmacion",modal:true,buttons:[
                            {
                                text:"Si",
                                click:function(){
                                    $(this).dialog("close");
                                    $.post("EliminarCliente",{idCliente:$("#idCliente").val()},function(data){
                                        $("#idCliente").val("");
                                        $("#idTipo").val("0");
                                        $("#nombres").val("");
                                        $("#apellidos").val("");
                                        $("#direccion").val("");
                                        $("#telefono").val("");
                                        $("#idCiudad").val("0");
                                        $("#fechaNacimiento").val("");
                                        $("#fechaIngreso").val("");
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
                if(validarCliente()){
                    if(validarTipo()){
                        if(validarNombres()){
                            if(validarApellidos()){
                                return validarApellidos()
                            }
                        }
                    }
                }
                return false;
            }

            function validarCliente(){
                if($("#idCliente").val() == ""){
                    $("<div></div>").html("Debe ingesar un Id de Cliente.").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarTipo(){
                if($("#idTipo").val() == "0"){
                    $("<div></div>").html("Debe seleccionar un tipo de Identificacion de Cliente.").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarNombres(){
                if($("#nombres").val() == ""){
                    $("<div></div>").html("Debe ingesar un nombre(s) de Cliente.").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarApellidos(){
                if($("#apellidos").val() == ""){
                    $("<div></div>").html("Debe ingesar el apellido(s) del Cliente.").dialog({
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

            // Obtenemos el valor como fue llamado el formulario. Se capturan como Strings
            String idCliente= "";
            String idTipo = "";
            String nombres = "";
            String apellidos = "";
            String direccion = "";
            String telefono = "";
            String idCiudad = "";
            String fechaNacimiento = "";
            String fechaIngreso = "";

            if(request.getParameter("idCliente") != null) idCliente = request.getParameter("idCliente");
            if(request.getParameter("idTipo") != null) idTipo = request.getParameter("idTipo");
            if(request.getParameter("nombres") != null) nombres = request.getParameter("nombres");
            if(request.getParameter("apellidos") != null) apellidos = request.getParameter("apellidos");
            if(request.getParameter("direccion") != null) direccion= request.getParameter("direccion");
            if(request.getParameter("telefono") != null) telefono = request.getParameter("telefono");
            if(request.getParameter("idCiudad") != null) idCiudad = request.getParameter("idCiudad");
            if(request.getParameter("fechaNacimiento") != null) fechaNacimiento = request.getParameter("fechaNacimiento");
            if(request.getParameter("fechaIngreso") != null) fechaIngreso = request.getParameter("fechaIngreso");

            // Si presiona el boton consultar
            if (consultar){
                Datos misDatos = new Datos();
                misDatos.conectar();
                Cliente miCliente = misDatos.getCliente(idCliente);
                if(miCliente==null){
                    mensaje = "Cliente no existe.";
                    idCliente = "";
                    idTipo = "";
                    nombres = "";
                    apellidos = "";
                    direccion = "";
                    telefono = "";
                    idCiudad = "";
                    fechaNacimiento = "";
                    fechaIngreso = "";
                }else{
                    idCliente = miCliente.getIdClientes();
                    idTipo = ""+miCliente.getIdTipo();
                    nombres = miCliente.getNombres();
                    apellidos = miCliente.getApellidos();
                    direccion = miCliente.getDireccion();
                    telefono = miCliente.getTelefono();
                    idCiudad = "" + miCliente.getIdCiudad();
                    fechaNacimiento = Utilidades.formatDate(miCliente.getFechaNacimiento());
                    fechaIngreso = Utilidades.formatDate(miCliente.getFechaIngreso());
                    mensaje = "Usuario consultado";
                }
                misDatos.desconectar();
            }

            // Para limpiar el formulario
            if(limpiar){
                idCliente = "";
                idTipo = "";
                nombres = "";
                apellidos = "";
                direccion = "";
                telefono = "";
                idCiudad = "";
                fechaNacimiento = "";
                fechaIngreso = "";
            }

            // Si presiona boton Nuevo
            if(nuevo){
                Datos misDatos = new Datos();
                misDatos.conectar();
                Cliente miCliente = misDatos.getCliente(idCliente);
                if(miCliente != null){
                    mensaje = "Cliente ya existe.";
                }else{
                    miCliente = new Cliente(idCliente,
                            Integer.parseInt(idTipo),
                            nombres,
                            apellidos,
                            direccion,
                            telefono,
                            Integer.parseInt(idCiudad),
                            Utilidades.stringToDate(fechaNacimiento),
                            new Date()
                    );
                    misDatos.newCliente(miCliente);
                    mensaje = "Cliente ingresado.";
                }
                misDatos.desconectar();
            }

            // Si presiona boton Modificar
            if(modificar){
                Datos misDatos = new Datos();
                misDatos.conectar();
                Cliente miCliente = misDatos.getCliente(idCliente);
                if(miCliente == null){
                    mensaje = "Usuario no existe";
                }else{
                    miCliente = new Cliente(idCliente,
                            Integer.parseInt(idTipo),
                            nombres,
                            apellidos,
                            direccion,
                            telefono,
                            Integer.parseInt(idCiudad),
                            Utilidades.stringToDate(fechaNacimiento),
                            Utilidades.stringToDate(fechaIngreso)
                    );
                    misDatos.updateCliente(miCliente);
                    mensaje = "Cliente modificado.";
                }
                misDatos.desconectar();
            }

            // Si presiona el boton borrar
            // Esto esta considerado en el jQuery del comienzo.

            // Si presiona Listar
            if(listar){
                %>
                    <jsp:forward page="ListadoClientes.jsp"></jsp:forward>
                <%
            }
        %>
        <h1>Clientes</h1>
        <form name = "Clientes" id = "Clientes" action = "Clientes.jsp" method = "POST">
            <table>
                <tr>
                    <td>Id. Cliente*:</td>
                    <td><input type="text" name="idCliente" id="idCliente" value="<%=idCliente%>" size="10"/></td>
                </tr>
                <tr>
                    <td>Tipo*:</td>
                    <td><select name="idTipo" id="idTipo">
                        <option value="0" <%=(idTipo.equals("") ? "selected":"")%> >Seleccione perfil...</option>
                        <option value="1" <%=(idTipo.equals("1") ? "selected":"")%> >Cedula de Ciudadania</option>
                        <option value="2" <%=(idTipo.equals("2") ? "selected":"")%> >Tarjeta de Identidad</option>
                        <option value="3" <%=(idTipo.equals("3") ? "selected":"")%> >Registro Civil</option>
                        <option value="4" <%=(idTipo.equals("4") ? "selected":"")%> >Cedula de Extranjeria</option>
                        <option value="5" <%=(idTipo.equals("5") ? "selected":"")%> >Pasaporte</option>

                    </select></td>
                </tr>
                <tr>
                    <td>Nombres*:</td>
                    <td><input type="text" name="nombres" id="nombres" value="<%=nombres%>" size="30"/></td>
                </tr>
                <tr>
                    <td>Apellidos*:</td>
                    <td><input type="text" name="apellidos" id="apellidos" value="<%=apellidos%>" size="30"/></td>
                </tr>
                <tr>
                    <td>Direccion:</td>
                    <td><input type="direccion" name="direccion" id="direccion" value="<%=direccion%>" size="50"/></td>
                </tr>
                <tr>
                    <td>Telefono:</td>
                    <td><input type="telefono" name="telefono" id="telefono"  value="<%=telefono%>" size="20"/></td>
                </tr>
                <tr>
                    <td>Ciudad:</td>
                    <td><select name="idCiudad" id="idCiudad">
                    <option value="0" <%=(idCiudad.equals("") ? "selected":"")%> >Seleccione ciudad...</option>
                    <option value="1" <%=(idCiudad.equals("1") ? "selected":"")%> >Guayaquil</option>
                    <option value="2" <%=(idCiudad.equals("2") ? "selected":"")%> >Milagro</option>
                    <option value="3" <%=(idCiudad.equals("3") ? "selected":"")%> >Babahoyo</option>
                    <option value="4" <%=(idCiudad.equals("4") ? "selected":"")%> >Yaguachi</option>
                    <option value="5" <%=(idCiudad.equals("5") ? "selected":"")%> >Jujan</option>
                        </select></td>
                </tr>
                <tr>
                    <td>Fecha de Nacimiento:</td>
                    <td><input type="fechaNacimiento" name="fechaNacimiento" id="fechaNacimiento"  value="<%=fechaNacimiento%>" size="10"/></td>
                </tr>
                <tr>
                    <td>Fecha de Ingreso:</td>
                    <td><input type="fechaIngreso" name="fechaIngreso" id="fechaIngreso"  value="<%=fechaIngreso%>" size="10" disabled="disabled"/></td>
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
