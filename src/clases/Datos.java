package clases;

import com.sun.corba.se.spi.orbutil.fsm.Guard;

import javax.xml.transform.Result;
import java.sql.*;
import java.util.*;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by Rostan on 28/01/2016.
 */
public class Datos {
    private Connection con;
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String DBMS = "mysql";
    private static final String HOST = "127.0.0.1";
    private static final String PORT = "3306";
    private static final String DATABASE = "facturacion";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public void conectar ()throws Exception{

        try{
            Class.forName(DRIVER);
            this.con = DriverManager.getConnection("jdbc:" + DBMS + "://" + HOST + ":" + PORT + "/" + DATABASE, USER, PASSWORD);
        }catch(Exception e){
            System.out.println("ERROR: NO SE PUDO CONECTAR CON LA BASE DE DATOS: "+e);
            throw e;
        }
        //System.out.println("CONEXION EXITOSA CON LA BASE DE DATOS");
    }

    public void desconectar(){
        try {
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }

    public Integer validarUsr(String usu,String pass){
        Integer perfil = 0;
        try {
            String sql = "SELECT * from usuarios where idUsuario = '"+usu+"' and clave = '"+pass+"'";

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            perfil = rs.next() ? rs.getInt("idPerfil"):0;

        } catch (SQLException e) {
            e.printStackTrace();
            perfil = 2;
        }
        return perfil;
    }

    public Usuario getUsuario(String idUsuario){
        try{

            Usuario miUsuario = null;

            String sql = "SELECT * from usuarios where idUsuario = '"+idUsuario+"'";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()){
                miUsuario = new Usuario(
                        rs.getString("idUsuario"),
                        rs.getString("nombres"),
                        rs.getString("apellidos"),
                        rs.getString("clave"),
                        rs.getInt("idPerfil"),
                        rs.getString("foto")
                );
            }
            return miUsuario;
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
            return null;
        }
    }

    public void newUsuario(Usuario miUsuario){
        try {
            String sql = "INSERT INTO usuarios values(" +
                    "'"+miUsuario.getIdUsuario()+"'," +
                    "'"+miUsuario.getNombres()+"'," +
                    "'"+miUsuario.getApellidos()+"'," +
                    "'"+miUsuario.getClave()+"',"
                    +miUsuario.getPerfil()+"," +
                    "'"+miUsuario.getFoto()+"')";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException ex){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,ex);
        }
    }

    public void updateUsuario(Usuario miUsuario){
        try {
            String sql = "UPDATE usuarios SET "
                    +"nombres = '"+miUsuario.getNombres()+"',"
                    +"apellidos = '"+miUsuario.getApellidos()+"',"
                    +"clave = '"+miUsuario.getClave()+"',"
                    +"idPerfil = "+miUsuario.getPerfil()+","
                    +"foto = '"+miUsuario.getFoto()+"',"
                    +"where idUsuario = '"+miUsuario.getIdUsuario()+"'";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException ex){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,ex);
        }
    }

    public void deleteUsuario(String idUsuario){
        try{
            String sql = "DELETE FROM usuarios WHERE idUsuario = '"+idUsuario+"'";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
        }
    }

    public ResultSet getUsuarios(){
        try{

            Usuario miUsuario = null;

            String sql = "SELECT * from usuarios";
            Statement st = con.createStatement();
            return st.executeQuery(sql);
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
            return null;
        }
    }

    public Cliente getCliente(String idCliente){
        try{

            Cliente miCliente = null;

            String sql = "select* from clientes where idCliente = '"+idCliente+"'";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()){
                miCliente = new Cliente(
                        rs.getString("idCliente"),
                        rs.getInt("idTipo"),
                        rs.getString("nombres"),
                        rs.getString("apellidos"),
                        rs.getString("direccion"),
                        rs.getString("telefono"),
                        rs.getInt("idCiudad"),
                        rs.getDate("fechaNacimiento"),
                        rs.getDate("fechaIngreso")
                );
            }
            return miCliente;
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
            return null;
        }
    }

    public ResultSet getClientes(){
        try{

            Usuario miCliente = null;

            String sql = "select* from clientes";
            Statement st = con.createStatement();
            return st.executeQuery(sql);
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
            return null;
        }
    }


    public void newCliente(Cliente miCliente){
        try {
            String sql = "INSERT INTO clientes values(" +
                    "'"+miCliente.getIdClientes()+"'," +
                    +miCliente.getIdTipo()+"," +
                    "'"+miCliente.getNombres()+"'," +
                    "'"+miCliente.getApellidos()+"',"+
                    "'"+miCliente.getDireccion()+"'," +
                    "'"+miCliente.getTelefono()+"',"+
                    +miCliente.getIdCiudad()+","+
                    "'"+Utilidades.formatDate(miCliente.getFechaNacimiento())+"',"+
                    "'"+Utilidades.formatDate(miCliente.getFechaIngreso())+"')";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException ex){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,ex);
        }
    }

    public void updateCliente(Cliente miCliente){
        try {
            String sql = "UPDATE clientes SET "
                    +"idTipo = "+miCliente.getIdTipo()+","
                    +"nombres = '"+miCliente.getNombres()+"',"
                    +"apellidos = '"+miCliente.getApellidos()+"',"
                    +"direccion = '"+miCliente.getDireccion()+"',"
                    +"telefono = '"+miCliente.getTelefono()+"',"
                    +"idCiudad = "+miCliente.getIdCiudad()+","
                    +"fechaNacimiento = '"+Utilidades.formatDate(miCliente.getFechaNacimiento())+"',"
                    +"fechaIngreso = '"+Utilidades.formatDate(miCliente.getFechaIngreso())+"'"
                    +"where idCliente = '"+miCliente.getIdClientes()+"'";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException ex){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,ex);
        }
    }

    public void deleteCliente(String idCliente){
        try{
            String sql = "DELETE FROM clientes WHERE idCliente = '"+idCliente+"'";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
        }
    }

    public Producto getproducto(String idProducto){
        try{

            Producto miProducto = null;

            String sql = "SELECT * from productos where idProducto = '"+idProducto+"'";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()){
                miProducto = new Producto(
                        rs.getString("idProducto"),
                        rs.getString("descripcion"),
                        rs.getInt("precio"),
                        rs.getInt("idIVA"),
                        rs.getString("notas"),
                        rs.getString("foto")
                );
            }
            return miProducto;
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
            return null;
        }
    }

    public ResultSet getProductos(){
        try{
            String sql = "SELECT * from productos";
            Statement st = con.createStatement();
            return st.executeQuery(sql);
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
            return null;
        }
    }

    public void newProducto(Producto miProducto){
        try {
            String sql = "INSERT INTO productos values(" +
                    "'"+miProducto.getIdProducto()+"'," +
                    "'"+miProducto.getDescripcion()+"'," +
                    +miProducto.getPrecio()+"," +
                    +miProducto.getIdIva()+","+
                    "'"+miProducto.getNotas()+"'," +
                    "'"+miProducto.getFoto()+"')";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException ex){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,ex);
        }
    }

    public void updateProducto(Producto miProducto){
        try {
            String sql = "UPDATE productos SET "
                    +"descripcion = '"+miProducto.getDescripcion()+"',"
                    +"precio = "+miProducto.getPrecio()+","
                    +"idIVA = "+miProducto.getIdIva()+","
                    +"notas = '"+miProducto.getNotas()+"',"
                    +"foto = '"+miProducto.getFoto()+"' "
                    +"WHERE idProducto = '"+miProducto.getIdProducto()+"'";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException ex){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,ex);
        }
    }

    public void deleteProducto(String idProducto){
        try{
            String sql = "DELETE FROM productos WHERE idProducto = '"+idProducto+"'";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
        }
    }

    public ResultSet getDetalleFacturaTmp(){
        try{
            String sql = "select* from detallefacturatmp";
            Statement st = con.createStatement();
            return st.executeQuery(sql);
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
            return null;
        }
    }

    public int getTotalCantidad(){
        try{
            int total = 0;

            String sql = "select sum(cantidad) as suma from detalleFacturaTmp";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()){
                total = rs.getInt("suma");
            }
            return total;
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
            return 0;
        }
    }

    public int getTotalValor(){
        try{
            int total = 0;

            String sql = "select sum(cantidad * precio) as suma from detalleFacturaTmp";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()){
                total = rs.getInt("suma");
            }
            return total;
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
            return 0;
        }
    }

    public void newDetalleFacturaRmp(DetalleFacturaTmp miDetalle){
        // Identificamos si el producto ya hace parte del detalle.
        try {
            String sql = "Select (1) from detallefacturatmp" +
                    " where idProducto = " + miDetalle.getIdProducto();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            if(rs.next()){
                // si existe, añadimos cantidad.
                sql = "UPDATE detallefacturatmp " +
                        "SET cantidad = cantidad +"+miDetalle.getCantidad()+" " +
                        "WHERE idProducto = '"+miDetalle.getIdProducto()+"'";
            }else{
                sql = "INSERT INTO detallefacturatmp VALUES ('"+miDetalle.getIdProducto()+"',"+
                        "'"+miDetalle.getDescripcion()+"',"+
                        miDetalle.getPrecio()+","+
                        miDetalle.getCantidad()+")";
            }

            st.executeUpdate(sql);
        }catch(Exception e){

        }
    }

    public void deleteDetalleFacturaTmp(String idProducto){
        try{
            String sql = "DELETE FROM detallefacturatmp WHERE idProducto = "+idProducto;
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
        }
    }

    public int siguenteFactura(){
        int numFac = 1;
        try {
            String sql = "SELECT MAX(idFactura) as NUM from factura";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()){
                numFac = rs.getInt("NUM") + 1;
            }else{
                return 1;
            }
            return numFac;
        }catch(Exception e){
            return 1;
        }
    }

    public void newFactura(int idFactura, String idCliente, Date fecha){
        try {
            String sql = "INSERT INTO factura VALUES("+idFactura+"," +
                    "'"+idCliente+"'," +
                    "'"+Utilidades.formatDate(fecha)+"')";

            Statement st = con.createStatement();
            st.executeUpdate(sql);

        }catch (Exception e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
        }
    }

    public void newDetalleFactura(int idFactura, int idLinea, String idProducto, String descripcion, int precio, int cantidad){

        PreparedStatement st = null;

        try {

            st = getCon().prepareStatement("INSERT INTO detallefactura VALUES(?,?,?,?,?,?)");
            st.setInt(1,idFactura);
            st.setInt(2,idLinea);
            st.setString(3,idProducto);
            st.setString(4,descripcion);
            st.setInt(5,precio);
            st.setInt(6,cantidad);

            st.executeUpdate();

        }catch (Exception e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
        }
    }

    public void deleteDetalleFacturaTmp(){
        try{
            String sql = "DELETE FROM detallefacturatmp";
            Statement st = con.createStatement();
            st.executeUpdate(sql);
        }catch(SQLException e){
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE,null,e);
        }
    }

    public ResultSet getResultSet(String sql){
        ResultSet rs = null;
        try{
            PreparedStatement st = getCon().prepareStatement(sql);
            rs = st.executeQuery();
        }catch(Exception e){

        }
        return rs;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }
}
