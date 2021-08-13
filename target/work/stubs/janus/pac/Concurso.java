package janus.pac;

import java.lang.*;
import java.io.*;
import java.net.*;
import java.util.*;
import groovy.lang.*;
import groovy.util.*;

public class Concurso
  extends java.lang.Object  implements
    groovy.lang.GroovyObject {
;
public  groovy.lang.MetaClass getMetaClass() { return (groovy.lang.MetaClass)null;}
public  void setMetaClass(groovy.lang.MetaClass mc) { }
public  java.lang.Object invokeMethod(java.lang.String method, java.lang.Object arguments) { return null;}
public  java.lang.Object getProperty(java.lang.String property) { return null;}
public  void setProperty(java.lang.String property, java.lang.Object value) { }
public  janus.Obra getObra() { return (janus.Obra)null;}
public  void setObra(janus.Obra value) { }
public  janus.Administracion getAdministracion() { return (janus.Administracion)null;}
public  void setAdministracion(janus.Administracion value) { }
public  janus.pac.Pac getPac() { return (janus.pac.Pac)null;}
public  void setPac(janus.pac.Pac value) { }
public  java.lang.String getCodigo() { return (java.lang.String)null;}
public  void setCodigo(java.lang.String value) { }
public  java.lang.String getObjeto() { return (java.lang.String)null;}
public  void setObjeto(java.lang.String value) { }
public  java.lang.Double getCostoBases() { return (java.lang.Double)null;}
public  void setCostoBases(java.lang.Double value) { }
public  java.lang.Double getPorMilBases() { return (java.lang.Double)null;}
public  void setPorMilBases(java.lang.Double value) { }
public  java.util.Date getFechaInicio() { return (java.util.Date)null;}
public  void setFechaInicio(java.util.Date value) { }
public  java.util.Date getFechaPublicacion() { return (java.util.Date)null;}
public  void setFechaPublicacion(java.util.Date value) { }
public  java.util.Date getFechaLimitePreguntas() { return (java.util.Date)null;}
public  void setFechaLimitePreguntas(java.util.Date value) { }
public  java.util.Date getFechaLimiteRespuestas() { return (java.util.Date)null;}
public  void setFechaLimiteRespuestas(java.util.Date value) { }
public  java.util.Date getFechaLimiteEntregaOfertas() { return (java.util.Date)null;}
public  void setFechaLimiteEntregaOfertas(java.util.Date value) { }
public  java.util.Date getFechaLimiteSolicitarConvalidacion() { return (java.util.Date)null;}
public  void setFechaLimiteSolicitarConvalidacion(java.util.Date value) { }
public  java.util.Date getFechaLimiteRespuestaConvalidacion() { return (java.util.Date)null;}
public  void setFechaLimiteRespuestaConvalidacion(java.util.Date value) { }
public  java.util.Date getFechaCalificacion() { return (java.util.Date)null;}
public  void setFechaCalificacion(java.util.Date value) { }
public  java.util.Date getFechaInicioPuja() { return (java.util.Date)null;}
public  void setFechaInicioPuja(java.util.Date value) { }
public  java.util.Date getFechaFinPuja() { return (java.util.Date)null;}
public  void setFechaFinPuja(java.util.Date value) { }
public  java.util.Date getFechaAdjudicacion() { return (java.util.Date)null;}
public  void setFechaAdjudicacion(java.util.Date value) { }
public  java.lang.String getEstado() { return (java.lang.String)null;}
public  void setEstado(java.lang.String value) { }
public  java.lang.String getObservaciones() { return (java.lang.String)null;}
public  void setObservaciones(java.lang.String value) { }
public  java.lang.Double getPresupuestoReferencial() { return (java.lang.Double)null;}
public  void setPresupuestoReferencial(java.lang.Double value) { }
public  java.util.Date getFechaAceptacionProveedor() { return (java.util.Date)null;}
public  void setFechaAceptacionProveedor(java.util.Date value) { }
public  java.lang.String getMemoRequerimiento() { return (java.lang.String)null;}
public  void setMemoRequerimiento(java.lang.String value) { }
public  java.util.Date getFechaAperturaOfertas() { return (java.util.Date)null;}
public  void setFechaAperturaOfertas(java.util.Date value) { }
public  java.util.Date getFechaInicioEvaluacionOferta() { return (java.util.Date)null;}
public  void setFechaInicioEvaluacionOferta(java.util.Date value) { }
public  java.util.Date getFechaLimiteResultadosFinales() { return (java.util.Date)null;}
public  void setFechaLimiteResultadosFinales(java.util.Date value) { }
public  java.util.Date getFechaInicioPreparatorio() { return (java.util.Date)null;}
public  void setFechaInicioPreparatorio(java.util.Date value) { }
public  java.util.Date getFechaEtapa1() { return (java.util.Date)null;}
public  void setFechaEtapa1(java.util.Date value) { }
public  java.util.Date getFechaEtapa2() { return (java.util.Date)null;}
public  void setFechaEtapa2(java.util.Date value) { }
public  java.util.Date getFechaEtapa3() { return (java.util.Date)null;}
public  void setFechaEtapa3(java.util.Date value) { }
public  java.util.Date getFechaFinPreparatorio() { return (java.util.Date)null;}
public  void setFechaFinPreparatorio(java.util.Date value) { }
public  java.util.Date getFechaInicioPrecontractual() { return (java.util.Date)null;}
public  void setFechaInicioPrecontractual(java.util.Date value) { }
public  java.util.Date getFechaFinPrecontractual() { return (java.util.Date)null;}
public  void setFechaFinPrecontractual(java.util.Date value) { }
public  java.util.Date getFechaInicioContractual() { return (java.util.Date)null;}
public  void setFechaInicioContractual(java.util.Date value) { }
public  java.util.Date getFechaFinContractual() { return (java.util.Date)null;}
public  void setFechaFinContractual(java.util.Date value) { }
public  java.lang.String getNumeroCertificacion() { return (java.lang.String)null;}
public  void setNumeroCertificacion(java.lang.String value) { }
public  java.util.Date getFechaNotificacionAdjudicacion() { return (java.util.Date)null;}
public  void setFechaNotificacionAdjudicacion(java.util.Date value) { }
public  java.lang.String getMemoSif() { return (java.lang.String)null;}
public  void setMemoSif(java.lang.String value) { }
public  java.lang.String getMemoCertificacionFondos() { return (java.lang.String)null;}
public  void setMemoCertificacionFondos(java.lang.String value) { }
public static  java.lang.Object getAuditable() { return null;}
public static  void setAuditable(java.lang.Object value) { }
public static  java.lang.Object getMapping() { return null;}
public static  void setMapping(java.lang.Object value) { }
public static  java.lang.Object getConstraints() { return null;}
public static  void setConstraints(java.lang.Object value) { }
}
