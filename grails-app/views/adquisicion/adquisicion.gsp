<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/08/21
  Time: 14:53
--%>

<%@ page import="janus.Grupo" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Adquisiciones
    </title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.livequery.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">
</head>

<body>

<div class="span12">
    <g:if test="${flash.message}">
        <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
            <a class="close" data-dismiss="alert" href="#">×</a>
            <elm:poneHtml textoHtml="${flash.message}"/>
        </div>
    </g:if>
</div>

<div class="span12 btn-group" role="navigation" style="background-color: #a8a8a8; padding: 5px; border-radius: 4px; width: 93%">
    <a href="#" class="btn  " id="btn_lista">
        <i class="icon-list-ul"></i>
        Lista
    </a>
    <a href="${g.createLink(controller: 'adquisicion', action: 'adquisicion')}" class="btn btn-ajax btn-new">
        <i class="icon-file-alt"></i>
        Nuevo
    </a>
    <g:if test="${adquisicion?.estado == 'N' || adquisicion.estado == null}">
        <a href="#" class="btn btn-ajax btn-new" id="guardar">
            <i class="icon-save"></i>
            Guardar
        </a>
    </g:if>
    <g:if test="${adquisicion?.id}">
        <g:if test="${consumo?.estado != 'A'}">
            <a href="#" class="btn btn-ajax btn-new" id="borrar">
                <i class="icon-trash"></i>
                Anular
            </a>
        </g:if>
    </g:if>
    <a href="${g.createLink(controller: 'adquisicion', action: 'adquisicion')}" class="btn btn-ajax btn-new">
        <i class="icon-remove"></i>
        Cancelar
    </a>
    <g:if test="${adquisicion?.estado == 'N'}">
        <g:if test="${adquisicion?.id >= 0}">
            <a href="#" class="btn btn-ajax btn-new" id="btnRegistrar">
                <i class="icon-check"></i>
                Registrar
            </a>
        </g:if>
    </g:if>
    <g:else>
        <g:if test="${adquisicion.estado == 'R'}">
            <g:if test="${adquisicion?.id}">
                <a href="#" class="btn btn-ajax btn-new" id="btnDesRegistrar">
                    <i class="icon-check"></i>
                    Desregistrar
                </a>
            </g:if>
        </g:if>
    </g:else>
    <a href="${createLink(controller: 'proveedor', action: 'proveedor', params: [id: adquisicion?.id >= 0 ?: null])}" class="btn">
        <i class="icon-user"></i>
        Proveedor
    </a>
</div>


<div id="list-grupo" class="span12" role="main" style="margin-top: 10px;margin-left: -10px">

    <div style="border-bottom: 1px solid black;padding-left: 50px;position: relative;">
        <g:form name="frmAdquisicion" action="save" style="height: 100px;">
            <input type="hidden" id="adquisicion__id" name="id" value="${adquisicion?.id}">
            <input type="hidden" name="proveedor" id="proveedor_id" value="${adquisicion?.proveedor?.id ?: ''}">

            <p class="css-vertical-text">Adquisición</p>

            <div class="linea" style="height: 100px;"></div>

            <div class="row-fluid">
                <div class="span10" style="width: 480px;">
                    Proveedor

                    <input type="text" name="proveedor_name" class="span20 allCaps required input-small"
                           value="${adquisicion?.id >= 0 ? (adquisicion?.proveedor?.ruc + " - " + adquisicion?.proveedor?.nombre) : ''}"
                           id="proveedor_nombre" maxlength="30"  readonly="" minlength="2">

                    <p class="help-block ui-helper-hidden"></p>
                </div>

                <g:if test="${adquisicion?.estado == 'N' || adquisicion?.estado == null}">
                    <div class="span1" style="margin-top: 20px; width: 80px">
                        <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar" id="input_codigo">
                            <i class="icon-search"></i> Buscar
                        </a>
                    </div>
                </g:if>

                <div class="span3">
                    Bodega
                    <g:select name="bodega" id="bodega" from="${bodegas}" class="span12" optionKey="id"
                              optionValue="descripcion"
                              value="${adquisicion?.bodega?.id}" noSelection="[null: '--Seleccione--']"/>
                </div>

                <div class="span2" style="width: 105px; margin-left: 10px">
                    Fecha
                    <elm:datepicker name="fecha" class="span24" value="${adquisicion?.fecha ?: new Date()}" id="fecha"/>
                </div>

                <div class="span2" style="width: 105px; margin-left: 10px">
                    Fecha Pago
                    <elm:datepicker name="fechaPago" class="span24" value="${adquisicion?.fechaPago ?: new Date()}" id="fechaPago"/>
                </div>

            </div>

            <div class="row-fluid">

                <div class="span6">
                    Concepto
                    <g:textField name="observaciones" value="${adquisicion?.observaciones}" maxlength="127"
                                 title="${adquisicion?.observaciones}" class="span12"/>
                </div>

                <div class="span1" style="width: 80px;">
                    IVA
                    %{--<g:textField name="iva" value="${adquisicion?.iva}"  title="IVA" class="span12"/>--}%
                    <g:textField name="iva"  title="IVA" class="span12"
                                 value="${g.formatNumber(number: adquisicion?.iva, maxFractionDigits: 2, minFractionDigits: 2,
                                         format: '##,##0', locale: 'ec')}" />
                </div>

                <div class="span1" style="width: 150px;">
                    Subtotal
                    %{--<g:textField name="subtotal" value="${adquisicion?.subtotal}" title="Subtotal" class="span12"/>--}%
                    <g:textField name="subtotal"  title="Subtotal" class="span12"
                                 value="${g.formatNumber(number: adquisicion?.subtotal, maxFractionDigits: 2, minFractionDigits: 2,
                                         format: '##,##0', locale: 'ec')}"/>
                </div>

                <div class="span1" style="width: 150px;">
                    Total
                    %{--<g:textField name="total" value="${adquisicion?.total}" readonly="" title="Total" class="span12"/>--}%
                    <g:textField name="total" readonly="" title="Total" class="span12"
                                 value="${g.formatNumber(number: adquisicion?.total, maxFractionDigits: 2, minFractionDigits: 2,
                                         format: '##,##0', locale: 'ec')}"/>
                </div>

                <div class="span1" style="width: 50px; color: #01a">
                    Estado
                    <g:textField name="estado" value="${adquisicion?.estado ?: 'N'}" readonly="true"
                                 title="${adquisicion?.estado == 'R' ? 'Registrado' : 'Ingresado'}" class="span12"/>
                </div>
            </div>
        </g:form>
    </div>

    <g:if test="${adquisicion?.estado == 'N'}">
        <g:if test="${adquisicion?.id}">
            <div style="border-bottom: 1px solid black;padding-left: 50px;margin-top: 10px;position: relative;">
                <p class="css-vertical-text">Items</p>

                <div class="linea" style="height: 100px;"></div>

                <div class="row-fluid" style="margin-bottom: 5px">

                    <div class="span1">
%{--                        <div style="display: inline-block">--}%
                            Código
%{--                        </div>--}%
                        <input type="text" name="item.codigo" id="cdgo_buscar" class="span12" style="width: 120px" readonly="true">
                        <input type="hidden" id="item_id_original">
                        <input type="hidden" id="idItems">
                    </div>

                    <g:if test="${adquisicion?.estado == 'N'}">
                        <div class="span1" style="margin-top: 22px; margin-left: 55px">
                            <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar Item" id="btnBuscarItem">
                                <i class="icon-search"></i>
                            </a>
                        </div>
                    </g:if>

                    <div class="span2" style="margin-left: -30px">
                        <div class="span3">
                            Lugar
                        </div>
                        <div class="span10">
                            <g:select name="lugar" from="${[0: 'Planta Baja', 1: 'Planta Alta', 2 : 'Local Exterior']}" class="form-control" optionValue="value" optionKey="key" style="width: 120px; margin-top: -10px"/>
                        </div>
                    </div>

                    <div class="span5" style="margin-left: -20px">
                        Descripción
                        <input type="text" name="item.descripcion" id="item_desc" class="span11" disabled="disabled">
                    </div>

                    <div class="span1" style="margin-right: 0px;margin-left: -30px;">
                        Unidad
                        <input type="text" name="item.unidad" id="item_unidad" class="span8" disabled="true">
                    </div>

                    <div class="span1" style="margin-left: -5px !important;">
                        Cantidad
                        <input type="text" name="item.cantidad" class="span12" id="item_cantidad" value="1"
                               style="text-align: right">
                    </div>

                    <div class="span2">
                        P. Unitario
                        <input type="text" name="item.precio" class="span8" id="item_precio" value="1"
                               style="text-align: right; color: #44a;">
                    </div>

                    <g:if test="${adquisicion?.estado == 'N'}">
                        <div class="span1" style="border: 0px solid black;height: 45px;padding-top: 22px;margin-left: 0px">
                            <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar"
                               id="btn_agregarItem">
                                <i class="icon-plus"></i>
                            </a>
                            <a class="btn btn-small btn-primary btn-ajax hidden" href="#" rel="tooltip" title="Guardar"
                               id="btn_guardarItem">
                                <i class="icon-save"></i>
                            </a>
                            <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Cancelar edición"
                               id="btnCancelarEdicion">
                                <i class="icon-remove"></i>
                            </a>
                        </div>
                    </g:if>
                </div>
            </div>

            <input type="hidden" id="actual_row">
        </g:if>
    </g:if>

    <g:if test="${adquisicion?.id >= 0}">
        <div style="border-bottom: 1px solid black;padding-left: 50px;position: relative;float: left;width: 95%; min-height: 200px"
             id="tablas">
            <p class="css-vertical-text">Detalle</p>

            <div class="linea" style="height: 98%;"></div>
            <table class="table table-bordered table-striped table-condensed table-hover" style="margin-top: 10px;">
                <thead>
                <tr>
                    <th style="width: 8%">Código</th>
                    <th style="width: 52%">Descripción</th>
                    <th style="width: 6%">Unidad</th>
                    <th style="width: 8%">Cantidad</th>
                    <th class="col_rend" style="width: 8%">C. Unitario</th>
                    <th class="col_rend" style="width: 10%">C. Total</th>
                    <th style="width: 8%" class="col_delete"></th>
                </tr>
                </thead>
                <tbody id="tabla_equipo">
                <g:set var="total" value="${0}"/>
                <g:each in="${detalles}" var="detalle" status="i">
                    <tr class="item_row " id="${detalle.id}">
                        <td class="col_hora" style="text-align: left">${detalle.item.codigo}</td>
                        <td class="col_hora" style="text-align: left">${detalle.item.nombre}</td>
                        <td class="col_rend rend" style="width: 50px;text-align: center">
                            ${detalle.item.unidad}
                        </td>
                        <td style="text-align: right" class="cant">
                            <g:formatNumber number="${detalle.cantidad}" format="##,###0" minFractionDigits="2"
                                            maxFractionDigits="2" locale="ec"/>
                        </td>
                        <td style="text-align: right" class="cant">
                            <g:formatNumber number="${detalle.precioUnitario}" format="##,#####0" minFractionDigits="5"
                                            maxFractionDigits="5" locale="ec"/>
                        </td>
                        <td style="text-align: right" class="cant">
                            <g:formatNumber number="${detalle.precioUnitario * detalle.cantidad}" format="##,#####0"
                                            minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
                        </td>
                        <td style="width: 50px;text-align: center" class="col_delete">
                            <g:if test="${adquisicion?.estado == 'N'}">
                                <a class="btn btn-small btn-primary editarItem" href="#" rel="tooltip" title="Editar"
                                   data-id="${detalle.id}"
                                   data-cant="${detalle.cantidad}" data-nombre="${detalle.item.nombre}"
                                   data-precio="${detalle.precioUnitario}"
                                   data-unidad="${detalle.item.unidad}" data-item="${detalle.item.id}" data-lugar="${detalle.lugar}"
                                   data-codigo="${detalle.item.codigo}">
                                    <i class="icon-edit"></i>
                                </a>
                                <a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar"
                                   data-id="${detalle.id}">
                                    <i class="icon-trash"></i>
                                </a>
                            </g:if>
                        </td>
                    </tr>
                    <g:set var="total" value="${total + (detalle.precioUnitario * detalle.cantidad)}"/>
                </g:each>
                <g:if test="${detalles.size() > 0}">
                    <tr class="item_row ">
                        <td class="col_hora" style="text-align: left" colspan="4"></td>
                        <td class="col_hora" style="text-align: right; font-weight: bold">TOTAL:</td>
                        <td style="text-align: right; font-weight: bold" class="cant">
                            <g:formatNumber number="${total}" format="##,##0" minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
                        </td>
                        <td class="col_hora" style="text-align: left"></td>
                    </tr>
                </g:if>
                </tbody>
            </table>

            <div id="tabla_indi"></div>

            <div id="tabla_costos" style="height: 120px;display: none;float: right;width: 100%;margin-bottom: 10px;"></div>
        </div>
    </g:if>
</div>

<div id="listaAdq" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarPorCnsm" class="buscarPor" from="${listaAdqc}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterio" id="criterioCnsm" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarCnsm" class="ordenar" from="${listaAdqc}" style="width: 100%" optionKey="key"
                          optionValue="value"/>
            </div>

            <div class="span2" style="margin-left: 60px">
                <button class="btn btn-info" id="btn-consumos"><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaAdqc" style="height: 460px; overflow: auto">
        </div>
    </fieldset>
</div>

<div id="buscarObra" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarPorObra" class="buscarPor" from="${listaAdqc}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterioObra" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarObra" class="ordenar" from="${listaAdqc}" style="width: 100%" optionKey="key"
                          optionValue="value"/>
            </div>

            <div class="span2" style="margin-left: 60px">
                <button class="btn btn-info" id="btn-obras"><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaObra" style="height: 460px; overflow: auto">
        </div>
    </fieldset>
</div>

<div id="busqueda" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Grupo</div>

            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarGrupo_name"  id="buscarGrupo" from="['1': 'Materiales', '2': 'Mano de Obra', '3': 'Equipos']"
                          style="width: 100%" optionKey="key" optionValue="value"/></div>

            <div class="span2"><g:select name="buscarPor" class="buscarPor" from="${listaItems}"
                                         style="width: 100%" optionKey="key"
                                         optionValue="value"/></div>

            <div class="span2">
                <g:textField name="criterio" class="criterio" style="width: 80%"/>
            </div>

            <div class="span2">
                <g:select name="ordenar" class="ordenar" from="${listaItems}"
                          style="width: 100%" optionKey="key"
                          optionValue="value"/></div>

            <div class="span2" style="margin-left: 60px"><button class="btn btn-info" id="btn-consultar"><i
                    class="icon-check"></i> Consultar
            </button></div>

        </div>
    </fieldset>

    <fieldset class="borde">
        <div id="divTabla" style="height: 460px; overflow-y:auto; overflow-x: auto;">
        </div>
    </fieldset>
</div>


<script type="text/javascript">

    function validarNumDec(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 190 || ev.keyCode == 110);
    }

    $("#iva, #subtotal, #item_cantidad, #item_precio").keydown(function (ev) {
        return validarNumDec(ev)
    });

    $(".borrarItem").click(function () {

        var id = $(this).data("id");
        $.box({
            imageClass: "box_info",
            text: "Está seguro que desea eliminar este item?",
            title: "Eliminar item",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $("#dlgLoad").dialog("open");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'adquisicion', action: 'eliminarItem_ajax')}',
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                $("#dlgLoad").dialog("close");
                                if (msg == 'ok') {
                                    $("#spanOk").html("Se ha eliminado el item correctamente");
                                    $("#divOk").show();
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                } else {
                                    $("#spanError").html("Error al eliminar el item");
                                    $("#divError").show()
                                }
                            }
                        })
                    },
                    "Cancelar": function () {

                    }
                }
            }
        });
    });

    $(".editarItem").click(function () {
        var comp = $(this).data("item");
        var cantidad = $(this).data("cant");
        var id = $(this).data("id");
        var nombre = $(this).data("nombre");
        var precio = $(this).data("precio");
        var codigo = $(this).data("codigo");
        var unidad = $(this).data("unidad");
        var lugar = $(this).data("lugar")
        $("#idItems").val(id);
        $("#item_id_original").val(comp);
        $("#item_cantidad").val(cantidad);
        $("#item_desc").val(nombre).addClass("readonly");
        $("#item_precio").val(precio);
        $("#item_unidad").val(unidad).addClass("readonly");
        $("#cdgo_buscar").val(codigo);
        $("#lugar").val(lugar);
        $("#btn_guardarItem").removeClass("hidden");
        $("#btn_agregarItem").addClass("hidden");
        // $("#btnCancelarEdicion").removeClass("hidden");
    });

    $("#btnCancelarEdicion").click(function () {
        $("#idItems").val("");
        $("#item_id_original").val("");
        $("#item_cantidad").val(1);
        $("#item_desc").val("").removeClass("readonly");
        $("#item_precio").val(1);
        $("#lugar").val(0);
        $("#item_unidad").val("").removeClass("readonly");
        $("#cdgo_buscar").val("")
        $("#btn_guardarItem").addClass("hidden");
        $("#btn_agregarItem").removeClass("hidden")
        // $("#btnCancelarEdicion").addClass("hidden")
    });

    var urlS = "${resource(dir:'images', file:'spinner_24.gif')}";
    var spinner = $("<img style='margin-left:15px;' src='" + urlS + "' alt='Cargando...'/>");

    $("#btnRegistrar").click(function () {
        var idAdquisicion = '${adquisicion?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de la adquisición a REGISTRADO?",
            title: "Registrar adquisicion",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $("#dlgLoad").dialog("open");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'adquisicion', action: 'registrar_ajax')}',
                            data: {
                                id: idAdquisicion
                            },
                            success: function (msg) {
                                $("#dlgLoad").dialog("close");
                                var parts = msg.split("_");
                                if (parts[0] == 'ok') {
                                    $("#spanOk").html("Adquisición registrada correctamente");
                                    $("#divOk").show();
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                } else {
                                    if(parts[0] == 'er'){
                                        $.box({
                                            imageClass: "box_info",
                                            text: parts[1],
                                            title: "Alerta",
                                            iconClose: false,
                                            dialog: {
                                                resizable: false,
                                                draggable: false,
                                                buttons: {
                                                    "Aceptar": function () {
                                                    }
                                                }
                                            }
                                        });
                                    }else{
                                        $("#spanError").html("Error al registrar la adquisición");
                                        $("#divError").show()
                                    }
                                }
                            }
                        })

                    },
                    "Cancelar": function () {

                    }
                }
            }
        });
    });


    $("#btnDesRegistrar").click(function () {
        var idAdquisicion = '${adquisicion?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de REGISTRADO de la adquisición?",
            title: "Quitar registro de adquisición",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $("#dlgLoad").dialog("open");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'adquisicion', action: 'quitarRegistrar_ajax')}',
                            data: {
                                id: idAdquisicion
                            },
                            success: function (msg) {
                                $("#dlgLoad").dialog("close");
                                var parts = msg.split("_");
                                if (parts[0] == 'ok') {
                                    $("#spanOk").html("Estado cambiado correctamente");
                                    $("#divOk").show();
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                } else {
                                    $("#spanError").html("Error al cambiar el estado de la adquisición");
                                    $("#divError").show()
                                }
                            }
                        })

                    },
                    "Cancelar": function () {

                    }
                }
            }
        });
    })

    $(function () {

        $("#btn_lista").click(function () {
            $("#listaAdq").dialog("open");
            $(".ui-dialog-titlebar-close").html("x")
        });

        $("#listaAdq").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            draggable: false,
            width: 1000,
            height: 600,
            position: 'center',
            title: 'Adquisiciones'
        });

        $("#btn-consumos").click(function () {
            buscaAdquisiciones();
        });

        function buscaAdquisiciones() {
            var buscarPor = $("#buscarPorCnsm").val();
            var criterio = $("#criterioCnsm").val();
            var ordenar = $("#ordenarCnsm").val();
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'adquisicion', action:'listaAdquisiciones')}",
                data: {
                    buscarPor: buscarPor,
                    criterio: criterio,
                    ordenar: ordenar

                },
                success: function (msg) {
                    $("#divTablaAdqc").html(msg);
                }
            });
        }

        <g:if test="${adquisicion?.id}">

        // $("#cdgo_buscar").dblclick(function () {
        $("#btnBuscarItem").click(function () {
            $("#busqueda").dialog("open");
            $(".ui-dialog-titlebar-close").html("x");
            return false;
        });
        </g:if>

        $("#busqueda").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            draggable: false,
            width: 1000,
            height: 600,
            position: 'center',
            title: 'Materiales y Equipos a Entregar'
        });

        $("#btn-consultar").click(function () {
            busqueda();
        });

        function busqueda() {
            var buscarPor = $("#buscarPor").val();
            var criterio = $(".criterio").val();
            var ordenar = $("#ordenar").val();
            var grupo = $("#buscarGrupo").val();
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'adquisicion', action:'listaItem')}",
                data: {
                    buscarPor: buscarPor,
                    criterio: criterio,
                    ordenar: ordenar,
                    grupo: grupo
                },
                success: function (msg) {
                    $("#divTabla").html(msg);
                }
            });
        }

        $("#input_codigo").click(function () {
            $("#buscarObra").dialog("open");
            $(".ui-dialog-titlebar-close").html("x");
            return false;
        });

        $("#buscarObra").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            draggable: false,
            width: 1000,
            height: 600,
            position: 'center',
            title: 'Lista de proveedores'
        });

        $("#btn-obras").click(function () {
            buscarObras();
        });

        function buscarObras() {
            var buscarPor = $("#buscarPorObra").val();
            var criterio = $("#criterioObra").val();
            var ordenar = $("#ordenar").val();
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'adquisicion', action:'listaProveedor')}",
                data: {
                    buscarPor: buscarPor,
                    criterio: criterio,
                    ordenar: ordenar
                },
                success: function (msg) {
                    $("#divTablaObra").html(msg);
                }
            });
        }

        $("#borrar").click(function () {
            $.box({
                imageClass: "box_info",
                text: "&nbsp;  Desea anular la adquisición,<br>&nbsp; ¿Está Seguro?",
                title: "Alerta",
                iconClose: false,
                dialog: {
                    resizable: false,
                    draggable: false,
                    buttons: {
                        "Aceptar": function () {
                            $.ajax({
                                type: "POST", url: "${g.createLink(controller: 'adquisicion',action:'anularAdquisicion')}",
                                data: "id=${adquisicion?.id}",
                                success: function (msg) {
                                    $("#dlgLoad").dialog("close");
                                    if (msg == "ok") {
                                        location.href = "${createLink(controller: 'adquisicion', action: 'adquisicion')}"
                                    } else {
                                        $.box({
                                            imageClass: "box_info",
                                            text: "Error al anular la adquisición",
                                            title: "Error",
                                            iconClose: false,
                                            dialog: {
                                                resizable: false,
                                                draggable: false,
                                                buttons: {
                                                    "Aceptar": function () {
                                                    }
                                                },
                                                width: 700
                                            }
                                        });
                                    }
                                }
                            });
                        },
                        "Cancelar": function () {
                        }
                    }
                }
            });
        });


        $("#cdgo_buscar").keydown(function (ev) {

            if (ev.keyCode * 1 != 9 && (ev.keyCode * 1 < 37 || ev.keyCode * 1 > 40)) {
                $("#item_tipoLista").val("")
                $("#item_id").val("")
                $("#item_desc").val("")
                $("#item_unidad").val("")
            } else {
//                ////console.log("no reset")
            }
        });

        $("#consumo_registro").click(function () {
            if ($(this).hasClass("active")) {
                if (confirm("Esta seguro de desregistrar este consumo?")) {
                    $("#registrado").val("N")
                    $("#fechaReg").val("")
                }
            } else {
                if (confirm("Esta seguro de registrar este consumo?")) {
                    $("#registrado").val("R")
                    var fecha = new Date()
                    $("#fechaReg").val(fecha.toString("dd/mm/yyyy"))
                }
            }
        });

        $("#guardar").click(function () {
            var proveedor = $("#proveedor_nombre").val()
            var bdga = $("#bodega").val()
            var iva = $("#iva").val();
            var subtotal = $("#subtotal").val();
            var observaciones = $("#observaciones").val();

            if (proveedor == '' || proveedor == null) {
                $.box({
                    imageClass: "box_info",
                    text: "Seleccione un proveedor",
                    title: "Alerta",
                    iconClose: false,
                    dialog: {
                        resizable: false,
                        draggable: false,
                        buttons: {
                            "Aceptar": function () {
                            }
                        }
                    }
                });
            } else {
                if (bdga == 'null') {
                    $.box({
                        imageClass: "box_info",
                        text: "Seleccione una bodega",
                        title: "Alerta",
                        iconClose: false,
                        dialog: {
                            resizable: false,
                            draggable: false,
                            buttons: {
                                "Aceptar": function () {
                                }
                            }
                        }
                    });
                } else {
                    if (iva == '' || iva == 'null') {
                        $.box({
                            imageClass: "box_info",
                            text: "Ingrese el IVA",
                            title: "Alerta",
                            iconClose: false,
                            dialog: {
                                resizable: false,
                                draggable: false,
                                buttons: {
                                    "Aceptar": function () {
                                    }
                                }
                            }
                        });
                    } else {
                        if (subtotal == '' || subtotal == 'null') {
                            $.box({
                                imageClass: "box_info",
                                text: "Ingrese un subtotal",
                                title: "Alerta",
                                iconClose: false,
                                dialog: {
                                    resizable: false,
                                    draggable: false,
                                    buttons: {
                                        "Aceptar": function () {
                                        }
                                    }
                                }
                            });
                        } else {
                            if (observaciones == '' || observaciones == 'null') {
                                $.box({
                                    imageClass: "box_info",
                                    text: "Ingrese el concepto",
                                    title: "Alerta",
                                    iconClose: false,
                                    dialog: {
                                        resizable: false,
                                        draggable: false,
                                        buttons: {
                                            "Aceptar": function () {
                                            }
                                        }
                                    }
                                });
                            } else {
                                guardarAdquisicion();
                            }
                        }
                    }
                }
            }
        });

        function guardarAdquisicion(){
            $("#dlgLoad").dialog("open");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'adquisicion', action: 'save')}',
                data: $("#frmAdquisicion").serialize(),
                success: function (msg) {
                    $("#dlgLoad").dialog("close");
                    var parts = msg.split("_")
                    if (parts[0] == 'ok') {
                        location.href = "${createLink(controller: 'adquisicion', action: 'adquisicion')}/" + parts[1]
                    } else {
                        $.box({
                            imageClass: "box_info",
                            text: "Error al guardar la adquisición",
                            title: "Error",
                            iconClose: false,
                            dialog: {
                                resizable: false,
                                draggable: false,
                                buttons: {
                                    "Aceptar": function () {
                                    }
                                }
                            }
                        });
                    }
                }
            });
        }

        function guardarDetalleAdquisición(id) {
            var lugar = $("#lugar option:selected").val()
            $("#dlgLoad").dialog("open");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'adquisicion', action: 'guardarDetalleAdquisicion_ajax')}',
                data: {
                    id: $("#idItems").val(),
                    item: $("#item_id_original").val(),
                    cantidad: $("#item_cantidad").val(),
                    precioUnitario: $("#item_precio").val(),
                    adquisicion: '${adquisicion?.id}',
                    lugar: lugar
                },
                success: function (msg) {
                    $("#dlgLoad").dialog("close");
                    if (msg == 'ok') {
                        location.href = "${createLink(controller: 'adquisicion', action: 'adquisicion')}/" + '${adquisicion?.id}'
                    } else {
                        $.box({
                            imageClass: "box_info",
                            text: "Error al agregar el item",
                            title: "Error",
                            iconClose: false,
                            dialog: {
                                resizable: false,
                                draggable: false,
                                buttons: {
                                    "Aceptar": function () {
                                    }
                                }
                            }
                        });
                    }
                }
            });
        }

        <g:if test="${adquisicion?.id}">

        $("#btn_agregarItem, #btn_guardarItem").click(function () {
            var id = $("#item_id").val();
            if ($('#item_desc').val().length == 0) {
                $.box({
                    imageClass: "box_info",
                    text: "Seleccione un item",
                    title: "Alerta",
                    iconClose: false,
                    dialog: {
                        resizable: false,
                        draggable: false,
                        buttons: {
                            "Aceptar": function () {
                            }
                        }
                    }
                });
            }else{
                if($("#item_cantidad").val() == '' || $("#item_cantidad").val() == null ||  $("#item_cantidad").val() == 0){
                    $.box({
                        imageClass: "box_info",
                        text: "Ingrese una cantidad",
                        title: "Alerta",
                        iconClose: false,
                        dialog: {
                            resizable: false,
                            draggable: false,
                            buttons: {
                                "Aceptar": function () {
                                }
                            }
                        }
                    });
                }else{
                    if($("#item_precio").val() == '' || $("#item_precio").val() == null || $("#item_precio").val() == 0){
                        $.box({
                            imageClass: "box_info",
                            text: "Ingrese un precio",
                            title: "Alerta",
                            iconClose: false,
                            dialog: {
                                resizable: false,
                                draggable: false,
                                buttons: {
                                    "Aceptar": function () {
                                    }
                                }
                            }
                        });
                    }else{
                        guardarDetalleAdquisición(id);
                    }
                }
            }
        });
        </g:if>
    });

</script>
</body>
</html>