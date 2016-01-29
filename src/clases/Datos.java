package clases;

import java.sql.*;

/**
 * Created by Rostan on 28/01/2016.
 */
public class Datos {
    private Connection con;

    public Datos(){
        try {
            Class.forName("com.mysql.jdbo.Driver");
            String db = "jdbc:mysql://localhost/facturacion";
            con = DriverManager.getConnection(db,"root","");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {;
            e.printStackTrace();
        }
    }

    public void desconectar(){
        try {
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }

    public boolean validarUsr(String usu,String pass){
        Boolean flag = null;
        try {
            String sql = "select (1) from usuarios where " +
                "idUsuario = '' and" +
                "clave = ' '";

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()){
                flag = true;
            }else{
                flag = false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            flag = false;
        }
        return flag;
    }
}
