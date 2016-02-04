<%@ page import="clases.Datos" %>
<%@ page import="clases.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: Bairon
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
                    return validarUsuario();
                });
            });

            function validarTodo(){
                if(validarUsuario()){
                    if(validarNombres()){
                        if(validarApellidos()){
                            if(validarClave()){
                                if(validarConfirmacion()){
                                    if(validarClaveYconfirmacion()){
                                        if(validarPerfil()){
                                            return validarPerfil();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                return false;
            }

            function validarUsuario(){
                if($("#idUsuario").val() == ""){
                    $("<div></div>").html("Debe ingesar un Id de Usuario").dialog({
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
                    $("<div></div>").html("Debe ingesar un nombre(s) de Usuario").dialog({
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
                    $("<div></div>").html("Debe ingesar el apellido(s) del Usuario").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarClave(){
                if($("#clave").val() == ""){
                    $("<div></div>").html("Debe ingesar clave para el Usuario").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarConfirmacion(){
                if($("#confirmacion").val() == ""){
                    $("<div></div>").html("Debe ingesar la confirmacion de la clave").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarClaveYconfirmacion(){
                if($("#clave").val() != $("#confirmacion").val()){
                    $("<div></div>").html("Clave y confirmacion no son iguales.").dialog({
                        title:"Error de validacion",modal:true,
                        buttons:[{text:"Ok",click:function(){
                            $(this).dialog("close");
                        }}]
                    });
                    return false;
                }
                return true;
            };

            function validarPerfil(){
                if($("#perfil").val() == "0"){
                    $("<div></div>").html("Debe asignar el Perfil del Usuario").dialog({
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
            String idUsuario = "";
            String nombres = "";
            String apellidos = "";
            String clave = "";
            String confirmacion = "";
            String perfil = "";
            String foto = "";

            if(request.getParameter("idUsuario") != null) idUsuario = request.getParameter("idUsuario");
            if(request.getParameter("nombres") != null) nombres = request.getParameter("nombres");
            if(request.getParameter("apellidos") != null) apellidos = request.getParameter("apellidos");
            if(request.getParameter("clave") != null) clave = request.getParameter("clave");
            if(request.getParameter("confirmacion") != null) confirmacion = request.getParameter("confirmacion");
            if(request.getParameter("perfil") != null) perfil = request.getParameter("perfil");
            if(request.getParameter("foto") != null) foto = request.getParameter("foto");

            // Si presiona el boton consultar
            if (consultar){
                if (idUsuario.equals("")) {
                    mensaje = "Debe ingresar el Id del Usuario";
                }else{
                    Datos misDatos = new Datos();
                    misDatos.conectar();
                    Usuario miUsuario = misDatos.getUsuario(idUsuario);
                    if(miUsuario==null){
                        mensaje = "Usuario no existe o error con la BD.";
                    }else{
                        idUsuario = miUsuario.getIdUsuario();
                        nombres = miUsuario.getNombres();
                        apellidos = miUsuario.getApellidos();
                        clave = miUsuario.getClave();
                        confirmacion = miUsuario.getClave();
                        perfil = "" + miUsuario.getPerfil();
                        foto = miUsuario.getFoto();
                        mensaje = "Usuario consultado";
                    }
                    misDatos.desconectar();
                }
            }

            // Para limpiar el formulario
            if(limpiar){
                idUsuario = "";
                nombres = "";
                apellidos = "";
                clave = "";
                confirmacion = "";
                perfil = "";
                foto = "";
                mensaje = "";
            }

            // Si presiona boton Nuevo
            if(nuevo){
                if(idUsuario.equals("")){
                    mensaje = "Debe ingresar un Id Usuario.";
                }else if (nombres.equals("")){
                    mensaje = "Debe ingresar un nombre(s) de usuario";
                }else if (apellidos.equals("")){
                    mensaje = "Debe ingresar un apellidos(s) de usuario";
                }else if (clave.equals("")){
                    mensaje = "Debe ingresar una clave de usuario";
                }else if (confirmacion.equals("")){
                    mensaje = "Debe ingresar una confirmacion de clave";
                }else if (perfil.equals("")){
                    mensaje = "Debe seleccionar un perfil de usuario";
                }else if (!clave.equals(confirmacion)){
                    mensaje = "La clave y la confirmacion deben ser iguales";
                }else{
                    Datos misDatos = new Datos();
                    misDatos.conectar();
                    Usuario miUsuario = misDatos.getUsuario(idUsuario);
                    if(miUsuario != null){
                        mensaje = "Usuario ya existe";
                    }else{
                        miUsuario = new Usuario(idUsuario,
                                nombres,
                                apellidos,
                                clave,
                                new Integer(perfil),
                                foto);
                        misDatos.newUsuario(miUsuario);
                        mensaje = "Usuario ingresado.";
                    }
                    misDatos.desconectar();
                }
            }

            // Si presiona boton Modificar
            if(modificar){
                if(idUsuario.equals("")){
                    mensaje = "Debe ingresar un Id Usuario.";
                }else if (nombres.equals("")){
                    mensaje = "Debe ingresar un nombre(s) de usuario";
                }else if (apellidos.equals("")){
                    mensaje = "Debe ingresar un apellidos(s) de usuario";
                }else if (clave.equals("")){
                    mensaje = "Debe ingresar una clave de usuario";
                }else if (confirmacion.equals("")){
                    mensaje = "Debe ingresar una confirmacion de clave";
                }else if (perfil.equals("")){
                    mensaje = "Debe seleccionar un perfil de usuario";
                }else if (!clave.equals(confirmacion)){
                    mensaje = "La clave y la confirmacion deben ser iguales";
                }else{
                    Datos misDatos = new Datos();
                    misDatos.conectar();
                    Usuario miUsuario = misDatos.getUsuario(idUsuario);
                    if(miUsuario == null){
                        mensaje = "Usuario no existe";
                    }else{
                        miUsuario = new Usuario(idUsuario,
                                nombres,
                                apellidos,
                                clave,
                                new Integer(perfil),
                                foto);
                        misDatos.updateUsuario(miUsuario);
                        mensaje = "Usuario modificado.";
                    }
                    misDatos.desconectar();
                }
            }

            // Si presiona el boton borrar
            if (borrar){
                if (idUsuario.equals("")) {
                    mensaje = "Debe ingresar el Id del Usuario";
                }else{
                    Datos misDatos = new Datos();
                    misDatos.conectar();

                    Usuario miUsuario = misDatos.getUsuario(idUsuario);
                    if(miUsuario==null){
                        mensaje = "Usuario no existe o error con la BD.";
                    }else{
                        misDatos.deleteUsuario(idUsuario);
                        idUsuario = "";
                        nombres = "";
                        apellidos = "";
                        clave = "";
                        confirmacion = "";
                        perfil = "";
                        foto = "";
                        mensaje = "Usuario borrado";
                    }
                    misDatos.desconectar();
                }
            }

            // Si presiona Listar
            if(listar){
                %>
                    <jsp:forward page="ListadoUsuarios.jsp"></jsp:forward>
                <%
            }
        %>
        <h1>Usuarios</h1>
        <form name = "Usuarios" id = "Usuarios" action = "Usuarios.jsp" method = "POST">
            <table>
                <tr>
                    <td>Id. Usuario*:</td>
                    <td><input type="text" name="idUsuario" id="idUsuario" value="<%=idUsuario%>" size="10"/></td>
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
                    <td>Clave*:</td>
                    <td><input type="password" name="clave" id="clave" value="<%=clave%>" size="10"/></td>
                </tr>
                <tr>
                    <td>Confirmacion*:</td>
                    <td><input type="password" name="confirmacion" id="confirmacion"  value="<%=confirmacion%>" size="10"/></td>
                </tr>
                <tr>
                    <td>Perfil*:</td>
                    <td><select name="perfil" id="perfil">
                        <%--Forma standard del If--%>
                        <%--<% if(perfil.equals("")){ %>--%>
                        <%--<option value="0" selected>Seleccione perfil...</option>--%>
                        <%--<% }else{ %>--%>
                        <%--<option value="0" >Seleccione perfil...</option>--%>
                        <%--<%} if (perfil.equals("1")){ %>--%>
                        <%--<option value="1" selected>Administrador</option>--%>
                        <%--<% }else{ %>--%>
                        <%--<option value="1" >Administrador</option>--%>
                        <%--<% } if (perfil.equals("2")){ %>--%>
                        <%--<option value="2" selected>Empleado</option>--%>
                        <%--<% }else{ %>--%>
                        <%--<option value="2" >Empleado</option>--%>
                        <%--<% }%>--%>

                        <%--Forma diferente--%>
                        <option value="0" <%=(perfil.equals("") ? "selected":"")%> >Seleccione perfil...</option>
                        <option value="1" <%=(perfil.equals("1") ? "selected":"")%> >Administrador</option>
                        <option value="2" <%=(perfil.equals("2") ? "selected":"")%> >Empleado</option>

                    </select></td>
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
                        <img style="height: 150px; width: 150px;" src="images/noImagen.png">
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
