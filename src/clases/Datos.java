package clases;

import javax.xml.transform.Result;
import java.sql.*;
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
            String sql = "select* from usuarios where idUsuario = '"+usu+"' and clave = '"+pass+"'";

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

            String sql = "select* from usuarios where idUsuario = '"+idUsuario+"'";
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
}
