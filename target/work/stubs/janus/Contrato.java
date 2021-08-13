package janus;

import java.lang.*;
import java.io.*;
import java.net.*;
import java.util.*;
import groovy.lang.*;
import groovy.util.*;

public class Contrato
  extends java.lang.Object  implements
    java.io.Serializable,    groovy.lang.GroovyObject {
;
public  groovy.lang.MetaClass getMetaClass() { return (groovy.lang.MetaClass)null;}
public  void setMetaClass(groovy.lang.MetaClass mc) { }
public  java.lang.Object invokeMethod(java.lang.String method, java.lang.Object arguments) { return null;}
public  java.lang.Object getProperty(java.lang.String property) { return null;}
public  void setProperty(java.lang.String property, java.lang.Object value) { }
public  janus.pac.Oferta getOferta() { return (janus.pac.Oferta)null;}
public  void setOferta(janus.pac.Oferta value) { }
public  janus.pac.TipoContrato getTipoContrato() { return (janus.pac.TipoContrato)null;}
public  void setTipoContrato(janus.pac.TipoContrato value) { }
public  janus.pac.TipoPlazo getTipoPlazo() { return (janus.pac.TipoPlazo)null;}
public  void setTipoPlazo(janus.pac.TipoPlazo value) { }
public  janus.Contrato getPadre() { return (janus.Contrato)null;}
public  void setPadre(janus.Contrato value) { }
public  janus.ejecucion.PeriodosInec getPeriodoInec() { return (janus.ejecucion.PeriodosInec)null;}
public  void setPeriodoInec(janus.ejecucion.PeriodosInec value) { }
public  java.lang.String getCodigo() { return (java.lang.String)null;}
public  void setCodigo(java.lang.String value) { }
public  java.lang.String getObjeto() { return (java.lang.String)null;}
public  void setObjeto(java.lang.String value) { }
public  java.util.Date getFechaSubscripcion() { return (java.util.Date)null;}
public  void setFechaSubscripcion(java.util.Date value) { }
public  java.util.Date getFechaIngreso() { return (java.util.Date)null;}
public  void setFechaIngreso(java.util.Date value) { }
public  java.util.Date getFechaInicio() { return (java.util.Date)null;}
public  void setFechaInicio(java.util.Date value) { }
public  java.util.Date getFechaFin() { return (java.util.Date)null;}
public  void setFechaFin(java.util.Date value) { }
public  java.lang.Double getMonto() { return (java.lang.Double)null;}
public  void setMonto(java.lang.Double value) { }
public  java.lang.Double getFinanciamiento() { return (java.lang.Double)null;}
public  void setFinanciamiento(java.lang.Double value) { }
public  java.lang.Double getPorcentajeAnticipo() { return (java.lang.Double)null;}
public  void setPorcentajeAnticipo(java.lang.Double value) { }
public  java.lang.Double getAnticipo() { return (java.lang.Double)null;}
public  void setAnticipo(java.lang.Double value) { }
public  java.lang.Double getMultas() { return (java.lang.Double)null;}
public  void setMultas(java.lang.Double value) { }
public  java.lang.Double getPlazo() { return (java.lang.Double)null;}
public  void setPlazo(java.lang.Double value) { }
public  java.lang.String getEstado() { return (java.lang.String)null;}
public  void setEstado(java.lang.String value) { }
public  java.lang.String getResponsableTecnico() { return (java.lang.String)null;}
public  void setResponsableTecnico(java.lang.String value) { }
public  java.util.Date getFechaFirma() { return (java.util.Date)null;}
public  void setFechaFirma(java.util.Date value) { }
public  java.lang.String getCuentaContable() { return (java.lang.String)null;}
public  void setCuentaContable(java.lang.String value) { }
public  java.lang.String getProrroga() { return (java.lang.String)null;}
public  void setProrroga(java.lang.String value) { }
public  java.lang.String getObservaciones() { return (java.lang.String)null;}
public  void setObservaciones(java.lang.String value) { }
public  java.lang.String getMemo() { return (java.lang.String)null;}
public  void setMemo(java.lang.String value) { }
public  java.lang.Double getMultaRetraso() { return (java.lang.Double)null;}
public  void setMultaRetraso(java.lang.Double value) { }
public  java.lang.Double getMultaPlanilla() { return (java.lang.Double)null;}
public  void setMultaPlanilla(java.lang.Double value) { }
public  java.lang.Double getMultaIncumplimiento() { return (java.lang.Double)null;}
public  void setMultaIncumplimiento(java.lang.Double value) { }
public  java.lang.Double getMultaDisposiciones() { return (java.lang.Double)null;}
public  void setMultaDisposiciones(java.lang.Double value) { }
public  java.util.Date getFechaPedidoRecepcionContratista() { return (java.util.Date)null;}
public  void setFechaPedidoRecepcionContratista(java.util.Date value) { }
public  java.util.Date getFechaPedidoRecepcionFiscalizador() { return (java.util.Date)null;}
public  void setFechaPedidoRecepcionFiscalizador(java.util.Date value) { }
public  janus.Departamento getDepAdministrador() { return (janus.Departamento)null;}
public  void setDepAdministrador(janus.Departamento value) { }
public  janus.Persona getDelegadoPrefecto() { return (janus.Persona)null;}
public  void setDelegadoPrefecto(janus.Persona value) { }
public  janus.Persona getDelegadoFiscalizacion() { return (janus.Persona)null;}
public  void setDelegadoFiscalizacion(janus.Persona value) { }
public  java.lang.String getClausula() { return (java.lang.String)null;}
public  void setClausula(java.lang.String value) { }
public  java.lang.String getNumeralPlazo() { return (java.lang.String)null;}
public  void setNumeralPlazo(java.lang.String value) { }
public  java.lang.String getNumeralAnticipo() { return (java.lang.String)null;}
public  void setNumeralAnticipo(java.lang.String value) { }
public  java.lang.Double getIndirectos() { return (java.lang.Double)null;}
public  void setIndirectos(java.lang.Double value) { }
public  janus.Obra getObraContratada() { return (janus.Obra)null;}
public  void setObraContratada(janus.Obra value) { }
public  janus.pac.Proveedor getContratista() { return (janus.pac.Proveedor)null;}
public  void setContratista(janus.pac.Proveedor value) { }
public  int getConReajuste() { return (int)0;}
public  void setConReajuste(int value) { }
public  java.lang.String getAdicionales() { return (java.lang.String)null;}
public  void setAdicionales(java.lang.String value) { }
public  int getAplicaReajuste() { return (int)0;}
public  void setAplicaReajuste(int value) { }
public  int getSaldoMulta() { return (int)0;}
public  void setSaldoMulta(int value) { }
public static  java.lang.Object getAuditable() { return null;}
public static  void setAuditable(java.lang.Object value) { }
public static  java.lang.Object getMapping() { return null;}
public static  void setMapping(java.lang.Object value) { }
public static  java.lang.Object getConstraints() { return null;}
public static  void setConstraints(java.lang.Object value) { }
public  java.lang.Object getObra() { return null;}
public  java.lang.Object getAdministradorContrato() { return null;}
public  java.lang.Object getAdministrador() { return null;}
public  java.lang.Object getFiscalizadorContrato() { return null;}
public  java.lang.Object getFiscalizador() { return null;}
}
