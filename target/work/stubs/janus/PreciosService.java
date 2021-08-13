package janus;

import java.lang.*;
import java.io.*;
import java.net.*;
import java.util.*;
import groovy.lang.*;
import groovy.util.*;

public class PreciosService
  extends java.lang.Object  implements
    groovy.lang.GroovyObject {
;
public  groovy.lang.MetaClass getMetaClass() { return (groovy.lang.MetaClass)null;}
public  void setMetaClass(groovy.lang.MetaClass mc) { }
public  java.lang.Object invokeMethod(java.lang.String method, java.lang.Object arguments) { return null;}
public  java.lang.Object getProperty(java.lang.String property) { return null;}
public  void setProperty(java.lang.String property, java.lang.Object value) { }
public  java.lang.Object getDbConnectionService() { return null;}
public  void setDbConnectionService(java.lang.Object value) { }
public  boolean getTransactional() { return false;}
public  boolean isTransactional() { return false;}
public  void setTransactional(boolean value) { }
public  java.lang.Object getPrecioItems(java.lang.Object fecha, java.lang.Object lugar, java.lang.Object items) { return null;}
public  java.lang.Object getPrecioItemsString(java.lang.Object fecha, java.lang.Object lugar, java.lang.Object items) { return null;}
public  java.lang.Object getPrecioItemStringListaDefinida(java.lang.Object fecha, java.lang.Object lugar, java.lang.Object item) { return null;}
public  java.lang.Object getPrecioRubroItem(java.lang.Object fecha, java.lang.Object lugar, java.lang.Object items) { return null;}
public  java.lang.Object getPrecioRubroItemEstado(java.lang.Object fecha, java.lang.Object lugar, java.lang.Object items, java.lang.Object registrado) { return null;}
public  java.lang.Object getPrecioRubroItemEstadoNoFecha(java.lang.Object lugar, java.lang.Object items, java.lang.Object registrado) { return null;}
public  java.lang.Object getPrecioRubroItemTipo(java.lang.Object fecha, java.lang.Object tipoLugar) { return null;}
public  java.lang.Object getPrecioRubroItemOrder(java.lang.Object fecha, java.lang.Object lugar, java.lang.Object items, java.lang.Object order, java.lang.Object sort) { return null;}
public  java.lang.Object getPrecioRubroItemOperador(java.lang.Object fecha, java.lang.Object lugar, java.lang.Object items, java.lang.Object operador) { return null;}
public  java.lang.Object rendimientoTranposrte(java.lang.Object dsps, java.lang.Object dsvl, java.lang.Object precioUnitChofer, java.lang.Object precioUnitVolquete) { return null;}
public  java.lang.Object rendimientoTransporteLuz(janus.Obra obra, java.lang.Object precioUnitChofer, java.lang.Object precioUnitVolquete) { return null;}
public  java.lang.Object rb_precios(java.lang.Object parametros, java.lang.Object condicion) { return null;}
public  java.lang.Object nv_rubros(java.lang.Object parametros) { return null;}
public  java.lang.Object rb_preciosAsc(java.lang.Object parametros, java.lang.Object condicion) { return null;}
public  java.lang.Object rb_preciosVae(java.lang.Object parametros, java.lang.Object condicion) { return null;}
public  java.lang.Object rb_precios(java.lang.Object select, java.lang.Object parametros, java.lang.Object condicion) { return null;}
public  java.lang.Object presioUnitarioVolumenObra(java.lang.Object select, java.lang.Object obra, java.lang.Object item) { return null;}
public  java.lang.Object precioUnitarioVolumenObraAsc(java.lang.Object select, java.lang.Object obra, java.lang.Object item) { return null;}
public  java.lang.Object precioUnitarioVolumenObraSinOrderBy(java.lang.Object select, java.lang.Object obra, java.lang.Object item) { return null;}
public  java.lang.Object precioVlob(java.lang.Object obra, java.lang.Object item) { return null;}
public  java.lang.Object ac_rbro(java.lang.Object rubro, java.lang.Object lugar, java.lang.Object fecha) { return null;}
public  java.lang.Object ac_rbroV2(java.lang.Object rubro, java.lang.Object fecha, java.lang.Object lugar) { return null;}
public  java.lang.Object ac_rbroObra(java.lang.Object obra) { return null;}
public  java.lang.Object rbro_pcun_v2(java.lang.Object obra) { return null;}
public  java.lang.Object valor_de_obra(java.lang.Object obra) { return null;}
public  java.lang.Object rbro_pcun_vae(java.lang.Object obra) { return null;}
public  java.lang.Object rbro_pcun_vae2(java.lang.Object obra, java.lang.Object subpres) { return null;}
public  java.lang.Object rbro_pcun_v2_item(java.lang.Object obra, java.lang.Object sbpr, java.lang.Object item) { return null;}
public  java.lang.Object rbro_pcun_v3(java.lang.Object obra, java.lang.Object subpres) { return null;}
public  java.lang.Object rbro_pcun_v4(java.lang.Object obra, java.lang.Object orden) { return null;}
public  java.lang.Object rbro_pcun_v5(java.lang.Object obra, java.lang.Object subpres, java.lang.Object orden) { return null;}
public  java.lang.Object vae_rb(java.lang.Object obra, java.lang.Object rubro) { return null;}
public  java.lang.Object verificaIndicesPeriodo(java.lang.Object plnl, java.lang.Object periodo) { return null;}
public  java.lang.Object verificaIndicesPeriodoTodo(java.lang.Object cntr, java.lang.Object prdo) { return null;}
public  java.lang.Object actualizaOrden(java.lang.Object volumen, java.lang.Object tipo) { return null;}
public  java.lang.Object ultimoDiaDelMes(java.lang.Object fecha) { return null;}
public  java.lang.Object sumaUnDia(java.lang.Object fecha) { return null;}
public  java.lang.Object primerDiaDelMes(java.lang.Object fecha) { return null;}
public  java.lang.Object componeMes(java.lang.Object mes) { return null;}
public  java.lang.Object ac_transporteDesalojo(java.lang.Object obra) { return null;}
public  java.lang.Object diasPlanillados(java.lang.Object plnl) { return null;}
public  java.lang.Object diasEsteMes(java.lang.Object cntr, java.lang.Object fcin, java.lang.Object fcfn) { return null;}
}
