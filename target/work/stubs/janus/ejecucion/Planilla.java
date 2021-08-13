package janus.ejecucion;

import java.lang.*;
import java.io.*;
import java.net.*;
import java.util.*;
import groovy.lang.*;
import groovy.util.*;

public class Planilla
  extends java.lang.Object  implements
    groovy.lang.GroovyObject {
;
public  groovy.lang.MetaClass getMetaClass() { return (groovy.lang.MetaClass)null;}
public  void setMetaClass(groovy.lang.MetaClass mc) { }
public  java.lang.Object invokeMethod(java.lang.String method, java.lang.Object arguments) { return null;}
public  java.lang.Object getProperty(java.lang.String property) { return null;}
public  void setProperty(java.lang.String property, java.lang.Object value) { }
public static  java.lang.Object getAuditable() { return null;}
public static  void setAuditable(java.lang.Object value) { }
public  janus.Contrato getContrato() { return (janus.Contrato)null;}
public  void setContrato(janus.Contrato value) { }
public  janus.ejecucion.TipoPlanilla getTipoPlanilla() { return (janus.ejecucion.TipoPlanilla)null;}
public  void setTipoPlanilla(janus.ejecucion.TipoPlanilla value) { }
public  janus.ejecucion.PeriodosInec getPeriodoIndices() { return (janus.ejecucion.PeriodosInec)null;}
public  void setPeriodoIndices(janus.ejecucion.PeriodosInec value) { }
public  java.lang.String getNumero() { return (java.lang.String)null;}
public  void setNumero(java.lang.String value) { }
public  java.util.Date getFechaPresentacion() { return (java.util.Date)null;}
public  void setFechaPresentacion(java.util.Date value) { }
public  java.util.Date getFechaIngreso() { return (java.util.Date)null;}
public  void setFechaIngreso(java.util.Date value) { }
public  java.lang.String getDescripcion() { return (java.lang.String)null;}
public  void setDescripcion(java.lang.String value) { }
public  double getValor() { return (double)0;}
public  void setValor(double value) { }
public  double getDescuentos() { return (double)0;}
public  void setDescuentos(double value) { }
public  double getReajuste() { return (double)0;}
public  void setReajuste(double value) { }
public  java.lang.String getObservaciones() { return (java.lang.String)null;}
public  void setObservaciones(java.lang.String value) { }
public  java.util.Date getFechaInicio() { return (java.util.Date)null;}
public  void setFechaInicio(java.util.Date value) { }
public  java.util.Date getFechaFin() { return (java.util.Date)null;}
public  void setFechaFin(java.util.Date value) { }
public  java.lang.Integer getDiasMultaDisposiciones() { return (java.lang.Integer)null;}
public  void setDiasMultaDisposiciones(java.lang.Integer value) { }
public  java.util.Date getFechaPago() { return (java.util.Date)null;}
public  void setFechaPago(java.util.Date value) { }
public  java.lang.String getOficioEntradaPlanilla() { return (java.lang.String)null;}
public  void setOficioEntradaPlanilla(java.lang.String value) { }
public  java.lang.String getMemoSalidaPlanilla() { return (java.lang.String)null;}
public  void setMemoSalidaPlanilla(java.lang.String value) { }
public  java.lang.String getMemoPedidoPagoPlanilla() { return (java.lang.String)null;}
public  void setMemoPedidoPagoPlanilla(java.lang.String value) { }
public  java.lang.String getMemoPagoPlanilla() { return (java.lang.String)null;}
public  void setMemoPagoPlanilla(java.lang.String value) { }
public  java.util.Date getFechaOficioEntradaPlanilla() { return (java.util.Date)null;}
public  void setFechaOficioEntradaPlanilla(java.util.Date value) { }
public  java.util.Date getFechaMemoSalidaPlanilla() { return (java.util.Date)null;}
public  void setFechaMemoSalidaPlanilla(java.util.Date value) { }
public  java.util.Date getFechaMemoPedidoPagoPlanilla() { return (java.util.Date)null;}
public  void setFechaMemoPedidoPagoPlanilla(java.util.Date value) { }
public  java.util.Date getFechaMemoPagoPlanilla() { return (java.util.Date)null;}
public  void setFechaMemoPagoPlanilla(java.util.Date value) { }
public  janus.Persona getFiscalizador() { return (janus.Persona)null;}
public  void setFiscalizador(janus.Persona value) { }
public  janus.ejecucion.Planilla getPadreCosto() { return (janus.ejecucion.Planilla)null;}
public  void setPadreCosto(janus.ejecucion.Planilla value) { }
public  java.lang.Double getAvanceFisico() { return (java.lang.Double)null;}
public  void setAvanceFisico(java.lang.Double value) { }
public  java.lang.String getDescripcionMulta() { return (java.lang.String)null;}
public  void setDescripcionMulta(java.lang.String value) { }
public  java.lang.Double getMultaEspecial() { return (java.lang.Double)null;}
public  void setMultaEspecial(java.lang.Double value) { }
public  java.lang.String getNoPago() { return (java.lang.String)null;}
public  void setNoPago(java.lang.String value) { }
public  java.lang.Double getNoPagoValor() { return (java.lang.Double)null;}
public  void setNoPagoValor(java.lang.Double value) { }
public  java.lang.String getLogPagos() { return (java.lang.String)null;}
public  void setLogPagos(java.lang.String value) { }
public  janus.ejecucion.FormulaPolinomicaReajuste getFormulaPolinomicaReajuste() { return (janus.ejecucion.FormulaPolinomicaReajuste)null;}
public  void setFormulaPolinomicaReajuste(janus.ejecucion.FormulaPolinomicaReajuste value) { }
public  java.lang.String getTipoContrato() { return (java.lang.String)null;}
public  void setTipoContrato(java.lang.String value) { }
public  janus.ejecucion.Planilla getPlanillaCmpl() { return (janus.ejecucion.Planilla)null;}
public  void setPlanillaCmpl(janus.ejecucion.Planilla value) { }
public  java.lang.String getNumeroOrden() { return (java.lang.String)null;}
public  void setNumeroOrden(java.lang.String value) { }
public  java.lang.String getMemoOrden() { return (java.lang.String)null;}
public  void setMemoOrden(java.lang.String value) { }
public  java.lang.String getNumeroCertificacionOrden() { return (java.lang.String)null;}
public  void setNumeroCertificacionOrden(java.lang.String value) { }
public  java.util.Date getFechaCertificacionOrden() { return (java.util.Date)null;}
public  void setFechaCertificacionOrden(java.util.Date value) { }
public  java.lang.String getGarantiaOrden() { return (java.lang.String)null;}
public  void setGarantiaOrden(java.lang.String value) { }
public  java.util.Date getFechaSuscripcionOrden() { return (java.util.Date)null;}
public  void setFechaSuscripcionOrden(java.util.Date value) { }
public  java.lang.String getNumeroTrabajo() { return (java.lang.String)null;}
public  void setNumeroTrabajo(java.lang.String value) { }
public  java.lang.String getMemoTrabajo() { return (java.lang.String)null;}
public  void setMemoTrabajo(java.lang.String value) { }
public  java.lang.String getNumeroCertificacionTrabajo() { return (java.lang.String)null;}
public  void setNumeroCertificacionTrabajo(java.lang.String value) { }
public  java.util.Date getFechaCertificacionTrabajo() { return (java.util.Date)null;}
public  void setFechaCertificacionTrabajo(java.util.Date value) { }
public  java.lang.String getGarantiaTrabajo() { return (java.lang.String)null;}
public  void setGarantiaTrabajo(java.lang.String value) { }
public  java.util.Date getFechaSuscripcionTrabajo() { return (java.util.Date)null;}
public  void setFechaSuscripcionTrabajo(java.util.Date value) { }
public  java.lang.String getCoordenadasVia() { return (java.lang.String)null;}
public  void setCoordenadasVia(java.lang.String value) { }
public static  java.lang.Object getMapping() { return null;}
public static  void setMapping(java.lang.Object value) { }
public static  java.lang.Object getConstraints() { return null;}
public static  void setConstraints(java.lang.Object value) { }
public  java.lang.String toString() { return (java.lang.String)null;}
}
