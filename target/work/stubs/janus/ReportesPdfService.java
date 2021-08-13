package janus;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import java.lang.*;
import java.io.*;
import java.net.*;
import java.util.*;
import groovy.lang.*;
import groovy.util.*;

public class ReportesPdfService
  extends java.lang.Object  implements
    groovy.lang.GroovyObject {
;
public  groovy.lang.MetaClass getMetaClass() { return (groovy.lang.MetaClass)null;}
public  void setMetaClass(groovy.lang.MetaClass mc) { }
public  java.lang.Object invokeMethod(java.lang.String method, java.lang.Object arguments) { return null;}
public  java.lang.Object getProperty(java.lang.String property) { return null;}
public  void setProperty(java.lang.String property, java.lang.Object value) { }
public  com.lowagie.text.Font getFontTituloGad() { return (com.lowagie.text.Font)null;}
public  void setFontTituloGad(com.lowagie.text.Font value) { }
public  com.lowagie.text.Font getFontInfo() { return (com.lowagie.text.Font)null;}
public  void setFontInfo(com.lowagie.text.Font value) { }
public  com.lowagie.text.Font getFontFooter() { return (com.lowagie.text.Font)null;}
public  void setFontFooter(com.lowagie.text.Font value) { }
public  com.lowagie.text.Font getFontHeader() { return (com.lowagie.text.Font)null;}
public  void setFontHeader(com.lowagie.text.Font value) { }
public  com.lowagie.text.Font getFontTh() { return (com.lowagie.text.Font)null;}
public  void setFontTh(com.lowagie.text.Font value) { }
public  com.lowagie.text.Font getFontTd() { return (com.lowagie.text.Font)null;}
public  void setFontTd(com.lowagie.text.Font value) { }
public  java.lang.Object crearDocumento(java.lang.String orientacion, java.lang.Object margenes) { return null;}
public  java.lang.Object crearDocumento(java.lang.String orientacion) { return null;}
public  java.lang.Object crearDocumento(java.lang.Object margenes) { return null;}
public  java.lang.Object crearDocumento() { return null;}
public  java.lang.Object propiedadesDocumento(com.lowagie.text.Document documento, java.lang.String title, java.lang.String subject, java.lang.String keywords, java.lang.String author, java.lang.String creator) { return null;}
public  java.lang.Object propiedadesDocumento(com.lowagie.text.Document documento, java.lang.String title, java.lang.String keywords) { return null;}
public  java.lang.Object propiedadesDocumento(com.lowagie.text.Document documento, java.lang.String title) { return null;}
public  java.lang.Object documentoFooter(com.lowagie.text.Document documento, java.lang.String footer, java.lang.Object numerosPagina, java.lang.Object bordes, int alignment) { return null;}
public  java.lang.Object documentoFooter(com.lowagie.text.Document documento, java.lang.String footer, java.lang.Object numerosPagina) { return null;}
public  java.lang.Object documentoFooter(com.lowagie.text.Document documento, java.lang.String footer) { return null;}
public  java.lang.Object documentoHeader(com.lowagie.text.Document documento, java.lang.String header, java.lang.Object numerosPagina, java.lang.Object bordes, java.lang.Object alignment) { return null;}
public  java.lang.Object documentoHeader(com.lowagie.text.Document documento, java.lang.String header, java.lang.Object numerosPagina) { return null;}
public  java.lang.Object documentoHeader(com.lowagie.text.Document documento, java.lang.String header) { return null;}
public  java.lang.Object crearTabla(java.lang.Object columnas, java.lang.Object width, java.lang.Object widthsColumnas, java.lang.Object espacioAntes, java.lang.Object espacioDespues) { return null;}
public  java.lang.Object crearTabla(java.lang.Object width, java.lang.Object widthsColumnas, java.lang.Object espacioAntes, java.lang.Object espacioDespues) { return null;}
public  java.lang.Object crearTabla(int columnas) { return null;}
public  java.lang.Object crearTabla(int... widthsColumnas) { return null;}
public  java.lang.Object crearTabla(int width, int... widthsColumnas) { return null;}
public  int[] arregloEnteros(java.lang.Object array) { return (int[])null;}
public  void addEmptyLine(com.lowagie.text.Paragraph paragraph, int number) { }
}
