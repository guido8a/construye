package janus.ejecucion;

import janus.*;
import janus.pac.*;
import java.lang.*;
import java.io.*;
import java.net.*;
import java.util.*;
import groovy.lang.*;
import groovy.util.*;

public class PlanillaController
  extends janus.seguridad.Shield  implements
    groovy.lang.GroovyObject {
;
public  groovy.lang.MetaClass getMetaClass() { return (groovy.lang.MetaClass)null;}
public  void setMetaClass(groovy.lang.MetaClass mc) { }
public  java.lang.Object invokeMethod(java.lang.String method, java.lang.Object arguments) { return null;}
public  java.lang.Object getProperty(java.lang.String property) { return null;}
public  void setProperty(java.lang.String property, java.lang.Object value) { }
public  java.lang.Object getPreciosService() { return null;}
public  void setPreciosService(java.lang.Object value) { }
public  java.lang.Object getBuscadorService() { return null;}
public  void setBuscadorService(java.lang.Object value) { }
public  java.lang.Object getDiasLaborablesService() { return null;}
public  void setDiasLaborablesService(java.lang.Object value) { }
public  java.lang.Object getContratoService() { return null;}
public  void setContratoService(java.lang.Object value) { }
public  java.lang.Object getDbConnectionService() { return null;}
public  void setDbConnectionService(java.lang.Object value) { }
public  java.lang.Object configPedidoPagoAnticipo() { return null;}
public  java.lang.Object configPedidoPago() { return null;}
public  java.lang.Object configOrdenInicioObra() { return null;}
public  java.lang.Object saveInicioObra() { return null;}
public  java.lang.Object savePedidoPagoAnticipo() { return null;}
public  java.lang.Object savePedidoPago() { return null;}
public  java.lang.Object errorIndice() { return null;}
public  java.lang.Object list() { return null;}
public  java.lang.Object listFiscalizador() { return null;}
public  java.lang.Object listFiscEx() { return null;}
public  java.lang.Object listAdmin() { return null;}
public  java.lang.Object listFinanciero() { return null;}
public  java.lang.Object pagar() { return null;}
public  java.lang.Object ordenPago() { return null;}
public  java.lang.Object saveOrdenPago() { return null;}
public  java.lang.Object savePago() { return null;}
public  java.lang.Object devolver_ajax() { return null;}
public  java.lang.Object saveDevolucionPlanilla() { return null;}
public  java.lang.Object pago_ajax() { return null;}
public  java.lang.Object inicioObra_ajax() { return null;}
public  java.lang.Object iniObraNoReajuste() { return null;}
public  java.lang.Object savePagoPlanilla() { return null;}
public  java.lang.Object iniciarObra() { return null;}
public  java.lang.Object form() { return null;}
public  java.lang.Object sinAnticipo() { return null;}
public  java.lang.Object getLastDayOfMonth(java.lang.Object fecha) { return null;}
public  java.lang.Object save() { return null;}
public  java.lang.Object saveSinAntc() { return null;}
public  java.lang.Object resumen() { return null;}
public  java.lang.Object detalle() { return null;}
public  java.lang.Object detalleNuevo() { return null;}
public  java.lang.Object dtEntrega() { return null;}
public  java.lang.Object addDetalleCosto() { return null;}
public  java.lang.Object deleteDetalleCosto() { return null;}
public  java.lang.Object detalleCosto() { return null;}
public  java.lang.Object saveDetalle() { return null;}
public  java.lang.Object saveDetalleNuevo() { return null;}
public  java.lang.Object errores() { return null;}
public  java.lang.Object letras() { return null;}
public  java.lang.Object procesarLq() { return null;}
public  java.lang.Object procEntrega() { return null;}
public  java.lang.Object indicesDisponiblesAnticipo(java.lang.Object plnl, java.lang.Object fcha, java.lang.Object tp) { return null;}
public  java.lang.Object indicesDisponibles(java.lang.Object plnl, java.lang.Object fcha, java.lang.Object tp) { return null;}
public  java.lang.Object insertaRjpl(java.lang.Object prmt) { return null;}
public  java.lang.Object detalleReajusteAnticipo(java.lang.Object id) { return null;}
public  java.lang.Object detalleReajuste(java.lang.Object id) { return null;}
public  java.lang.Object insertaDtrj(java.lang.Object prmt) { return null;}
public  java.lang.Object valorIndice(java.lang.Object indc, java.lang.Object prin) { return null;}
public  java.lang.Object procesaMultas(java.lang.Object id) { return null;}
public  java.lang.Object procesaMultasSinRj(java.lang.Object id) { return null;}
public  java.lang.Object multasEntrega(java.lang.Object id) { return null;}
public  java.lang.Object errorDiasLaborables(java.lang.Object cntr, java.lang.Object anio, java.lang.Object mnsj) { return null;}
public  java.lang.Object insertaMulta(java.lang.Object prmt) { return null;}
public  java.lang.Object procesaReajusteLq(java.lang.Object id) { return null;}
public  java.lang.Object calculaPo(java.lang.Object id, java.lang.Object vlor, java.lang.Object plFinal, java.lang.Object prdo) { return null;}
public  java.lang.Object procesaAdicionales(java.lang.Object plnl) { return null;}
public  java.lang.Object poneTotalReajuste(java.lang.Object plnl) { return null;}
public  java.lang.Object ponePeriodos(java.lang.Object tipos, java.lang.Object cntr, java.lang.Object antc, java.lang.Object periodosEjec, java.lang.Object finalObra) { return null;}
public  java.lang.Object prorrateaPo(java.lang.Object fprj, java.lang.Object cntr, java.lang.Object plnl) { return null;}
public  java.lang.Object registraRjpl(java.lang.Object prdo, java.lang.Object esteMes, java.lang.Object plAcumulado, java.lang.Object contrato, java.lang.Object planilla, java.lang.Object fcin, java.lang.Object fcfn, java.lang.Object crpa, java.lang.Object crac, java.lang.Object planillaFinal) { return null;}
public  java.lang.Object anticipo_ajax() { return null;}
public  java.lang.Object ordenCambio_ajax() { return null;}
public  java.lang.Object ordenTrabajo_ajax() { return null;}
public  java.lang.Object saveOrdenCambio() { return null;}
public  java.lang.Object saveOrdenTrabajo() { return null;}
}
