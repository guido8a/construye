package janus.ejecucion;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import java.awt.*;
import java.lang.*;
import java.io.*;
import java.net.*;
import java.util.*;
import groovy.lang.*;
import groovy.util.*;

public class ReportePlanillas3Controller
  extends java.lang.Object  implements
    groovy.lang.GroovyObject {
;
public  groovy.lang.MetaClass getMetaClass() { return (groovy.lang.MetaClass)null;}
public  void setMetaClass(groovy.lang.MetaClass mc) { }
public  java.lang.Object invokeMethod(java.lang.String method, java.lang.Object arguments) { return null;}
public  java.lang.Object getProperty(java.lang.String property) { return null;}
public  void setProperty(java.lang.String property, java.lang.Object value) { }
public  java.lang.Object getPreciosService() { return null;}
public  void setPreciosService(java.lang.Object value) { }
public  java.lang.Object getPlanillasService() { return null;}
public  void setPlanillasService(java.lang.Object value) { }
public  java.lang.Object getDbConnectionService() { return null;}
public  void setDbConnectionService(java.lang.Object value) { }
public  java.lang.Object componeMes(java.lang.Object mes) { return null;}
public  java.lang.Object reportePlanilla() { return null;}
public  java.lang.Object reportePlanillaNuevo() { return null;}
public  java.lang.Object rptPlnlEntrega() { return null;}
public  java.lang.Object reportePlanillaTotal() { return null;}
public  java.lang.Object reporteTablas(java.lang.Object planilla, java.lang.Object fpReajuste) { return null;}
public  java.lang.Object rpSinTablas(java.lang.Object planilla) { return null;}
public  java.lang.Object ponePeriodoPlanilla(java.lang.Object plnl) { return null;}
public  java.lang.Object resumenAnticipo(java.lang.Object planilla) { return null;}
public  java.lang.Object multas(java.lang.Object planilla, java.lang.Object tipo) { return null;}
public  java.lang.Object detalleAdicional(java.lang.Object planilla, java.lang.Object tipoRprt) { return null;}
public  java.lang.Object detalleTodo(java.lang.Object planilla, java.lang.Object tipoRprt) { return null;}
public  java.lang.Object detalle(java.lang.Object planilla, java.lang.Object tipoRprt) { return null;}
public  java.lang.Object graficarFooter(java.lang.Object pdfw, java.lang.Object planilla) { return null;}
public  java.lang.Object detalleEntrega(java.lang.Object planilla, java.lang.Object tipoRprt) { return null;}
public  java.lang.Object titlLogo() { return null;}
public  java.lang.Object titlInst(java.lang.Object espacio, java.lang.Object planilla, java.lang.Object obra) { return null;}
public  java.lang.Object titlSbtt(java.lang.Object fcha) { return null;}
public  java.lang.Object encabezado(java.lang.Object espacio, java.lang.Object size, java.lang.Object planilla, java.lang.Object tipo) { return null;}
public  java.lang.Object firmas(java.lang.Object tipo, java.lang.Object orientacion, java.lang.Object planilla) { return null;}
public  java.lang.Object firmas2(java.lang.Object tipo, java.lang.Object orientacion, java.lang.Object planilla) { return null;}
public  java.lang.Object detalleTodo2(java.lang.Object planilla, java.lang.Object tipoRprt) { return null;}
public  java.lang.Object suspension(java.lang.Object contrato) { return null;}
public  java.lang.Object fechaAnticipo(java.lang.Object contrato) { return null;}
public  java.lang.Object fechaFinObra(java.lang.Object contrato) { return null;}
public  java.lang.Object porcentajeAvance(java.lang.Object cntr, java.lang.Object plnl, java.lang.Object tipo) { return null;}
public class HeaderFooterPageEvent
  extends com.lowagie.text.pdf.PdfPageEventHelper  implements
    groovy.lang.GroovyObject {
;
public HeaderFooterPageEvent
(java.lang.Object planilla) {}
public  groovy.lang.MetaClass getMetaClass() { return (groovy.lang.MetaClass)null;}
public  void setMetaClass(groovy.lang.MetaClass mc) { }
public  java.lang.Object invokeMethod(java.lang.String method, java.lang.Object arguments) { return null;}
public  java.lang.Object getProperty(java.lang.String property) { return null;}
public  void setProperty(java.lang.String property, java.lang.Object value) { }
public  janus.ejecucion.Planilla getPlanilla() { return (janus.ejecucion.Planilla)null;}
public  void setPlanilla(janus.ejecucion.Planilla value) { }
public  void onEndPage(com.lowagie.text.pdf.PdfWriter writer, com.lowagie.text.Document document) { }
}
}
