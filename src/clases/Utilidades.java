package clases;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by HP on 08/02/2016.
 */
public class Utilidades {

    public static String formatDate(Date fecha) {
        if (fecha == null) {
            fecha = new Date();
        }
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy/MM/dd");
        return formatoDelTexto.format(fecha);
    }

    public static Date stringToDate(String fecha){
        SimpleDateFormat formatoTexto = new SimpleDateFormat("yyyy/MM/dd");
        Date aux = null;
        try{
            aux = formatoTexto.parse(fecha);
        }catch (Exception e){
        }
        return aux;
    }

    public static String Tipo(int idTipo){
        switch (idTipo){
            case 1: return "Cedula de Ciudadania";
            case 2: return "Tarjeta de identidad";
            case 3: return "Registro Civil";
            case 4: return "Cedula de Extranjeria";
            case 5: return "Pasaporte";
            default: return "Sin definir";
        }
    }

    public static String Ciudad(int idCiudad){
        switch (idCiudad){
            case 1: return "Guayaquil";
            case 2: return "Milagro";
            case 3: return "Babahoyo";
            case 4: return "Yaguachi";
            case 5: return "Jujan";
            default: return "Sin definir";
        }
    }

    public static boolean isNumeric(String cadena){
        if (cadena != "") {
            try {
                Integer.parseInt(cadena);
                return true;
            } catch (NumberFormatException nfe) {
                return false;
            }
        }else{
            return false;
        }
    }

    public static int stringToInt(String cadena){
        int aux = 0;
        if (cadena != "") {
            try {
                aux = Integer.parseInt(cadena);
                return aux;
            } catch (NumberFormatException nfe) {
                return aux;
            }
        }else{
            return aux;
        }
    }

    public static String IVA(int idIva){
        switch (idIva){
            case 1: return "0%";
            case 2: return "10%";
            case 3: return "12%";
            default: return "Sin definir";
        }
    }

}
