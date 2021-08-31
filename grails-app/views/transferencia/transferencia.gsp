<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 10/08/21
  Time: 12:39
--%>

<%@ page import="janus.Grupo" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Transferencia
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
    <a href="${g.createLink(controller: 'transferencia', action: 'transferencia')}" class="btn btn-ajax btn-new">
        <i class="icon-file-alt"></i>
        Nuevo
    </a>
    <g:if test="${transferencia?.estado == 'N' || transferencia?.estado == null}">
        <a href="#" class="btn btn-ajax btn-new" id="guardar">
            <i class="icon-save"></i>
            Guardar
        </a>
    </g:if>
    <g:if test="${transferencia?.id}">
        <g:if test="${transferencia?.estado != 'A'}">
            <a href="#" class="btn btn-ajax btn-new" id="borrar">
                <i class="icon-trash"></i>
                Anular
            </a>
        </g:if>
    </g:if>
    <a href="${g.createLink(controller: 'transferencia', action: 'transferencia')}" class="btn btn-ajax btn-new">
        <i class="icon-remove"></i>
        Cancelar
    </a>
    <g:if test="${transferencia?.estado == 'N'}">
        <g:if test="${transferencia?.id}">
            <a href="#" class="btn btn-ajax btn-new" id="btnRegistrar">
                <i class="icon-check"></i>
                Registrar
            </a>
        </g:if>
    </g:if>
    <g:else>
        <g:if test="${transferencia?.estado == 'R'}">
            <g:if test="${transferencia?.id}">
                <a href="#" class="btn btn-ajax btn-new" id="btnDesRegistrar">
                    <i class="icon-check"></i>
                    Desregistrar
                </a>
            </g:if>
        </g:if>
    </g:else>

    <g:if test="${transferencia?.id}">
        <a href="#" class="btn btn-ajax btn-new" id="imprimir" title="Imprimir">
            <i class="icon-print"></i>
            Imprimir
        </a>
        <a href="#" class="btn btn-ajax btn-new" id="excel" title="Imprimir">
            <i class="icon-print"></i>
            Excel
        </a>
    </g:if>
</div>

<div id="list-grupo" class="span12" role="main" style="margin-top: 10px;margin-left: -10px">

    <div style="border-bottom: 1px solid black;padding-left: 50px;position: relative;">
        <g:form name="frmTransferencia" action="save" style="height: 100px;">
            <input type="hidden" id="id" name="id" value="${transferencia?.id}">

            <p class="css-vertical-text">Transferencia</p>

            <div class="linea" style="height: 100px;"></div>

            <div class="row-fluid">
                <div class="span3">
                    Bodega
                    <g:select name="sale" id="bodegaSale" from="${bodegaSale}" class="span12" optionKey="id"
                              optionValue="descripcion"
                              value="${transferencia?.sale?.id}" noSelection="[null: '--Seleccione--']"/>
                </div>

                <div class="span3">
                    Destinatario
                    <g:select name="recibe" id="bodegaRecibe" from="${bodegaRecibe}" class="span12" optionKey="id"
                              optionValue="descripcion"
                              value="${transferencia?.recibe?.id}" noSelection="[null: '--Seleccione--']"/>
                </div>

                <div class="span2" style="width: 105px; margin-left: 10px">
                    Fecha
                    <elm:datepicker name="fecha" class="span24" value="${transferencia?.fecha ?: new Date()}" id="fecha"/>
                </div>

                <div class="span1" style="width: 50px; color: #01a">
                    Estado
                    <g:textField name="estado" value="${transferencia?.estado ?: 'N'}" readonly="true"
                                 title="${transferencia?.estado == 'R' ? 'Registrado' : (transferencia?.estado == 'A' ? 'Anulado' : 'Ingresado')}" class="span12"/>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span1" style="width: 750px">
                    Observaciones
                    <g:textField name="observaciones" value="${transferencia?.observaciones}" maxlength="127" title="${transferencia?.observaciones}" class="span12"/>
                </div>
            </div>

        </g:form>
    </div>
    <g:if test="${transferencia?.estado == 'N'}">
        <g:if test="${transferencia?.id}">
            <div style="border-bottom: 1px solid black;padding-left: 50px;margin-top: 10px;position: relative;">
                <p class="css-vertical-text">Items</p>

                <div class="linea" style="height: 100px;"></div>

                <div class="row-fluid" style="margin-bottom: 5px">

                    <div class="span2">

                        <div style="display: inline-block">
                            Código
                        </div>
                        <input type="text" name="item.codigo" id="cdgo_buscar" class="span12" readonly="true">
                        <input type="hidden" id="item_id">
                        <input type="hidden" id="idItems">
                    </div>

                    <g:if test="${transferencia?.estado == 'N'}">
                        <div class="span1" style="margin-top: 20px; width: 80px">
                            <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar Item" id="btnBuscarItem">
                                <i class="icon-search"></i> Buscar
                            </a>
                        </div>
                    </g:if>

                    <div class="span5">
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
                               style="text-align: right; color: #44a;" readonly="true">
                    </div>

                    <g:if test="${transferencia?.estado != 'R' || transferencia?.estado != 'A'}">
                        <div class="span1" style="border: 0px solid black;height: 45px;padding-top: 22px;margin-left: 10px">
                            <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar"
                               id="btn_agregarItem">
                                <i class="icon-plus"></i>
                            </a>
                            <a class="btn btn-small btn-primary btn-ajax hidden" href="#" rel="tooltip" title="Guardar"
                               id="btn_guardarItem">
                                <i class="icon-save"></i>
                            </a>
                            <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Cancelar"
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

    <g:if test="${transferencia?.id}">
        <div style="border-bottom: 1px solid black;padding-left: 50px;position: relative;float: left;width: 95%; min-height: 200px" id="tablas">
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
                                        <td class="col_hora" style="text-align: left">${detalle?.item?.codigo}</td>
                                        <td class="col_hora" style="text-align: left">${detalle?.item?.nombre}</td>
                                        <td class="col_rend rend" style="width: 50px;text-align: center">
                                            ${detalle?.item.unidad}
                                        </td>
                                        <td style="text-align: right" class="cant">
                                            <g:formatNumber number="${detalle?.cantidad}" format="##,###0" minFractionDigits="2"
                                                            maxFractionDigits="2" locale="ec"/>
                                        </td>
                                        <td style="text-align: right" class="cant">
                                            <g:formatNumber number="${detalle?.precioUnitario}" format="##,#####0" minFractionDigits="5"
                                                            maxFractionDigits="5" locale="ec"/>
                                        </td>
                                        <td style="text-align: right" class="cant">
                                            <g:formatNumber number="${detalle?.precioUnitario * detalle?.cantidad}" format="##,#####0"
                                                            minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
                                        </td>
                                        <td style="width: 50px;text-align: center" class="col_delete">
                                            <g:if test="${transferencia?.estado == 'N'}">
                                                <a class="btn btn-small btn-primary editarItem" href="#" rel="tooltip" title="Editar"
                                                   data-id="${detalle.id}"
                                                   data-cant="${detalle.cantidad}" data-nombre="${detalle.item.nombre}"
                                                   data-precio="${detalle.precioUnitario}"
                                                   data-unidad="${detalle?.item?.unidad}" data-item="${detalle?.item?.id}"
                                                   data-codigo="${detalle?.item?.codigo}">
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
                                            <g:formatNumber number="${total}" format="##,#####0" minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
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

<div id="listaConsumo" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarPorCnsm" class="buscarPor" from="${listaTransferencia}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterio" id="criterioCnsm" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarCnsm" class="ordenar" from="${listaTransferencia}" style="width: 100%" optionKey="key"
                          optionValue="value"/>
            </div>

            <div class="span2" style="margin-left: 60px">
                <button class="btn btn-info" id="btn-consumos"><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaCnsm" style="height: 460px; overflow: auto">
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
                <g:select name="buscarGrupo_name" class="buscarPor" id="buscarGrupo" from="['1': 'Materiales', '2': 'Mano de Obra', '3': 'Equipos']"
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


    $("#btnDesRegistrar").click(function () {
        $("#dlgLoad").dialog("open");
        var idTranferencia = '${transferencia?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de REGISTRADO de la transferencia?",
            title: "Quitar registro de la transferencia",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'transferencia', action: 'quitarRegistrar_ajax')}',
                            data: {
                                id: idTranferencia
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
                                    $("#spanError").html("Error al cambiar el estado de la transferencia");
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

    $("#item_cantidad, #item_precio").keydown(function (ev) {
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
                        $("#dlgLoad").dialog("open")
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'transferencia', action: 'eliminarItem_ajax')}',
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                $("#dlgLoad").dialog("close")
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
        $("#idItems").val(id);
        $("#item_id").val(comp);
        $("#item_cantidad").val(cantidad);
        $("#item_desc").val(nombre).addClass("readonly");
        $("#item_precio").val(precio)
        $("#item_unidad").val(unidad).addClass("readonly");
        $("#cdgo_buscar").val(codigo)
        $("#btn_guardarItem").removeClass("hidden");
        $("#btn_agregarItem").addClass("hidden");
        // $("#btnCancelarEdicion").removeClass("hidden");
    });

    $("#btnCancelarEdicion").click(function () {
        $("#idItems").val("");
        $("#item_id").val("");
        $("#item_cantidad").val(1);
        $("#item_desc").val("").removeClass("readonly");
        $("#item_precio").val(1)
        $("#item_unidad").val("").removeClass("readonly");
        $("#cdgo_buscar").val("")
        $("#btn_guardarItem").addClass("hidden");
        $("#btn_agregarItem").removeClass("hidden")
        // $("#btnCancelarEdicion").addClass("hidden")
    });

    var urlS = "${resource(dir:'images', file:'spinner_24.gif')}";
    var spinner = $("<img style='margin-left:15px;' src='" + urlS + "' alt='Cargando...'/>");

    $("#btnRegistrar").click(function () {
        var idTransferencia = '${transferencia?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de esta transferencia",
            title: "Registrar trasnferencia",
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
                            url: '${createLink(controller: 'transferencia', action: 'registrar_ajax')}',
                            data: {
                                id: idTransferencia
                            },
                            success: function (msg) {
                                $("#dlgLoad").dialog("close");
                                if (msg == 'ok') {
                                    $.box({
                                        imageClass: "box_info",
                                        text: "Tranferencia registrada correctamente",
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
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                } else {
                                    $.box({
                                        imageClass: "box_info",
                                        text: "Error al registrar la transferencia",
                                        title: "Alerta",
                                        iconClose: false,
                                        dialog: {
                                            resizable: false,
                                            draggable: false,
                                            buttons: {
                                                "Aceptar": function () {
                                                }
                                            },
                                            // width: 700
                                        }
                                    });
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

    $("#btnQuitarRegistro").click(function () {
        var idTransferencia = '${transferencia?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de esta" + '<p style="margin-left: 42px">' + "transferencia a " +
                '<strong style="color: #ff5c34">' + "NO APROBADO" + "?" + '</strong>' + '</p>',
            title: "Quitar registro de la transferencia",
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
                            url: '${createLink(controller: 'transferencia', action: 'quitarRegistrar_ajax')}',
                            data: {
                                id: idTransferencia
                            },
                            success: function (msg) {
                                $("#dlgLoad").dialog("close");
                                if (msg == 'ok') {
                                    $.box({
                                        imageClass: "box_info",
                                        text: "Estado de la transferencia cambiada correctamente",
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
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                } else {
                                    $.box({
                                        imageClass: "box_info",
                                        text: "Error al cambiar el estado de la transferencia",
                                        title: "Alerta",
                                        iconClose: false,
                                        dialog: {
                                            resizable: false,
                                            draggable: false,
                                            buttons: {
                                                "Aceptar": function () {
                                                }
                                            },
                                            // width: 700
                                        }
                                    });
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

    $(function () {

        $("#btn_lista").click(function () {
            $("#listaConsumo").dialog("open");
            $(".ui-dialog-titlebar-close").html("x")
        });

        $("#listaConsumo").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            draggable: false,
            width: 1000,
            height: 600,
            position: 'center',
            title: 'Transferencias'
        });

        $("#btn-consumos").click(function () {
            buscaTransferencias();
        });

        function buscaTransferencias() {
            var buscarPor = $("#buscarPorCnsm").val();
            var criterio = $("#criterioCnsm").val();
            var ordenar = $("#ordenarCnsm").val();
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'transferencia', action:'listaTransferencia')}",
                data: {
                    buscarPor: buscarPor,
                    criterio: criterio,
                    ordenar: ordenar

                },
                success: function (msg) {
                    $("#divTablaCnsm").html(msg);
                }
            });
        }

        <g:if test="${transferencia?.id}">

        // $("#cdgo_buscar").dblclick(function () {
        $("#btnBuscarItem").click(function () {
            $("#busqueda").dialog("open");
            $(".ui-dialog-titlebar-close").html("x")
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
            var bdga = $("#bodegaSale").val();
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'transferencia', action:'listaItem')}",
                data: {
                    buscarPor: buscarPor,
                    criterio: criterio,
                    ordenar: ordenar,
                    grupo: grupo,
                    bdga: bdga
                },
                success: function (msg) {
                    $("#divTabla").html(msg);
                }
            });
        }

        <g:if test="${!transferencia?.id}">
        $("#input_codigo").dblclick(function () {
            $("#buscarObra").dialog("open");
            $(".ui-dialog-titlebar-close").html("x")
            return false;
        });
        </g:if>

        $("#buscarObra").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            draggable: false,
            width: 1000,
            height: 600,
            position: 'center',
            title: 'Materiales y Equipos a Entregar'
        });

        $("#btn-obras").click(function () {
            buscarObras();
        });

        function buscarObras() {
            var buscarPor = $("#buscarPor").val();
            var criterio = $(".criterio").val();
            var ordenar = $("#ordenar").val();
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'consumo', action:'listaObra')}",
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
                text: "Desea anular la Transferencia,<br>¿Está Seguro?",
                title: "Alerta",
                iconClose: false,
                dialog: {
                    resizable: false,
                    draggable: false,
                    buttons: {
                        "Aceptar": function () {
                            $("#dlgLoad").dialog("open");
                            $.ajax({
                                type: "POST", url: "${g.createLink(controller: 'transferencia',action:'anularTransferencia')}",
                                data: "id=${transferencia?.id}",
                                success: function (msg) {
                                    $("#dlgLoad").dialog("close");
                                    if (msg == "ok") {
                                        location.href = "${createLink(controller: 'transferencia', action: 'transferencia')}/" + '${transferencia?.id}'
                                    } else {
                                        if(msg == 'er'){
                                            $.box({
                                                imageClass: "box_info",
                                                text: "No se puede anular la transferencia, tiene detalles asociados",
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
                                            $.box({
                                                imageClass: "box_info",
                                                text: "Error al anular la transferencia",
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
                                        }

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

            var bdgaSale = $("#bodegaSale").val();
            var bdgaRecibe = $("#bodegaRecibe").val();

            if (bdgaSale == 'null') {
                $.box({
                    imageClass: "box_info",
                    text: "Seleccione una bodega de salida",
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
                if (bdgaRecibe == 'null') {
                    $.box({
                        imageClass: "box_info",
                        text: "Seleccione una bodega de ingreso",
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
                    guardarTransferencia();
                }
            }
        });

        function guardarTransferencia(){
            $("#dlgLoad").dialog("open");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'transferencia', action: 'save')}',
                data: $("#frmTransferencia").serialize(),
                success: function (msg) {
                    $("#dlgLoad").dialog("close");
                    var parts = msg.split("_");
                    if (parts[0] == 'ok') {
                        location.href = "${createLink(controller: 'transferencia', action: 'transferencia')}/" + parts[1]
                    } else {
                        $.box({
                            imageClass: "box_info",
                            text: "Error al guardar la transferencia",
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

        function guardarDetalleTransferencia(id) {
            $("#dlgLoad").dialog("open");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'transferencia', action: 'guardarDetalleTransferencia_ajax')}',
                data: {
                    id: $("#idItems").val(),
                    item: $("#item_id").val(),
                    cantidad: $("#item_cantidad").val(),
                    precioUnitario: $("#item_precio").val(),
                    transferencia: '${transferencia?.id}'
                },
                success: function (msg) {
                    $("#dlgLoad").dialog("close");
                    var parts = msg.split("_")
                    if (parts[0] == 'ok') {
                        location.href = "${createLink(controller: 'transferencia', action: 'transferencia')}/" + '${transferencia?.id}'
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
                }
            });
        }


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
                if($("#item_cantidad").val() == '' || $("#item_cantidad").val() == '' || $("#item_cantidad").val() == 0){
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
                    if($("#item_precio").val() == '' || $("#item_precio").val() == '' || $("#item_precio").val() == 0){
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
                        guardarDetalleTransferencia(id);
                    }
                }
            }
        });
    });
</script>
</body>
</html>