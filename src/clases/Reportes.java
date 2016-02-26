package clases;

import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.sun.corba.se.spi.orbutil.fsm.Guard;

import java.io.FileOutputStream;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by HP on 25/02/2016.
 */
public class Reportes {
    public static void reporteFacturas(ResultSet rs, String fechaInicial, String fechaFinal){
        String ruta = "C:\\Users\\HP\\Documents\\GrupoSinNombre\\KB\\JavaWeb\\web\\images\\Reporte.pdf";
        Document documento = new Document();
        try {
            PdfWriter.getInstance(documento, new FileOutputStream(ruta));

            documento.open();

            PdfPTable tabla;

            // Colocamos titulo al reporte
            String texto = "Reporte de Facturas";
            Paragraph parrafo = new Paragraph(texto);
            documento.add(parrafo);

            texto = "Fecha Inicial: "+fechaInicial;
            parrafo = new Paragraph(texto);
            documento.add(parrafo);
            texto = "Fecha Final: "+fechaFinal;
            parrafo = new Paragraph(texto);
            documento.add(parrafo);

            texto = " ";
            parrafo = new Paragraph(texto);
            documento.add(parrafo);

            // Vaiables de totales
            int totGenCan = 0;
            int totGenVal = 0;
            int totFacCan = 0;
            int totFacVal = 0;

            // Leemos el registro el ResultSet
            boolean hayRegistros = rs.next();


            // Ciclo que recorre el ResultSet
            while(hayRegistros){
                // Colocamos encabesado de Factura.
                tabla = new PdfPTable(2);
                tabla.addCell("Id. Factura:");
                tabla.addCell(rs.getString("idFactura"));
                tabla.addCell("Id. Cliente:");
                tabla.addCell(rs.getString("idCliente"));
                tabla.addCell("Nombre: ");
                tabla.addCell(rs.getString("nombreCompleto"));
                tabla.addCell("Fecha: ");
                tabla.addCell(rs.getString("fecha"));

                parrafo = new Paragraph();
                parrafo.add(tabla);
                documento.add(parrafo);

                tabla = new PdfPTable(6);
                tabla.addCell("Id. Linea:");
                tabla.addCell("Id. Producto:");
                tabla.addCell("Descripcion:");
                tabla.addCell("Precio:");
                tabla.addCell("Cantidad:");
                tabla.addCell("Valor:");

                int facturaActual = rs.getInt("idFactura");

                // Inicializamos totales de factura
                totFacCan = 0;
                totFacVal = 0;

                while(hayRegistros && facturaActual == rs.getInt("idFactura")){
                    tabla.addCell(rs.getString("idLinea"));
                    tabla.addCell(rs.getString("idProducto"));
                    tabla.addCell(rs.getString("descripcion"));
                    tabla.addCell(rs.getString("precio"));
                    tabla.addCell(rs.getString("cantidad"));
                    tabla.addCell(rs.getString("valor"));

                    totFacCan += rs.getInt("cantidad");
                    totFacVal += rs.getInt("valor");

                    hayRegistros = rs.next();

                }

                tabla.addCell(" ");
                tabla.addCell(" ");
                tabla.addCell(" ");
                tabla.addCell("TOTAL ");
                tabla.addCell(""+totFacCan);
                tabla.addCell(""+totFacVal);

                totGenCan += totFacCan;
                totGenVal += totFacVal;

                parrafo = new Paragraph();
                parrafo.add(tabla);
                documento.add(parrafo);

                texto = " ";
                parrafo = new Paragraph(texto);
                documento.add(parrafo);
            }

            texto = " ";
            parrafo = new Paragraph(texto);
            documento.add(parrafo);

            // Tabla de Totales Finales
            tabla = new PdfPTable(6);
            tabla.addCell(" ");
            tabla.addCell(" ");
            tabla.addCell(" ");
            tabla.addCell("TOTAL GENERAL ");
            tabla.addCell(""+totGenCan);
            tabla.addCell(""+totGenVal);

            parrafo = new Paragraph();
            parrafo.add(tabla);
            documento.add(parrafo);

        }catch(Exception e){
            Logger.getLogger(Reportes.class.getName()).log(Level.SEVERE,null,e);
        }finally{
            documento.close();
        }
    }
}
