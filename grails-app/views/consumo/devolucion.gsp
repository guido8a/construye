<%@ page import="janus.Grupo" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Devoluciones
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

<div class="span12 btn-group" role="navigation">
    <a href="#" class="btn  " id="btn_lista">
        <i class="icon-list-ul"></i>
        Lista
    </a>
    <a href="${g.createLink(controller: 'consumo', action: 'devolucion')}" class="btn btn-ajax btn-new">
        <i class="icon-file-alt"></i>
        Nuevo
    </a>
    <g:if test="${consumo?.estado == 'N' || consumo?.estado == null}">
        <a href="#" class="btn btn-ajax btn-new" id="guardar">
            <i class="icon-save"></i>
            Guardar
        </a>
    </g:if>
    <g:if test="${consumo?.id}">
        <a href="#" class="btn btn-ajax btn-new" id="borrar">
            <i class="icon-trash"></i>
            Anular
        </a>
    </g:if>
    <a href="${g.createLink(controller: 'consumo', action: 'devolucion')}" class="btn btn-ajax btn-new">
        <i class="icon-remove"></i>
        Cancelar
    </a>
    <g:if test="${consumo?.estado == 'N'}">
        <g:if test="${consumo?.id}">
            <a href="#" class="btn btn-ajax btn-new" id="btnRegistrar">
                <i class="icon-check"></i>
                Registrar
            </a>
        </g:if>
    </g:if>
    <g:else>
        <g:if test="${consumo?.estado == 'R'}">
            <g:if test="${consumo?.id}">
                <a href="#" class="btn btn-ajax btn-new" id="btnDesRegistrar">
                    <i class="icon-check"></i>
                    Desregistrar
                </a>
            </g:if>
        </g:if>
    </g:else>

    <g:if test="${consumo?.id}">
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
        <g:form name="frmRubro" action="save" style="height: 100px;">
            <input type="hidden" id="obra__id" name="obra__id" value="${consumo?.obra?.id}">
            <input type="hidden" id="consumo__id" name="id" value="${consumo?.id}">

            <p class="css-vertical-text">Devolución</p>

            <div class="linea" style="height: 100px;"></div>

            <div class="row-fluid">
                <div class="span2" style="width: 150px;">
                    Obra
                    <input type="text" name="obra" class="span20 allCaps required input-small"
                           value="${consumo?.obra?.codigo}"
                           id="input_codigo" maxlength="30" minlength="2">


                    <p class="help-block ui-helper-hidden"></p>
                </div>

                <div class="span7" style="margin-left: 10px">
                    Descripción
                    <input type="text" name="nombre" class="span72" value="${consumo?.obra?.nombre}" id="obradscr">
                </div>

                <div class="span2">
                    Tipo de Requisición
                    <g:select name="tipoConsumo" id="tipoConsumo" from="${construye.TipoConsumo.get(2)}"
                              class="span12" optionKey="id" optionValue="descripcion"
                              value="${consumo?.tipoConsumo?.id}" />
                </div>

                <div class="span2" style="width: 105px; margin-left: 10px">
                    Fecha
                    <elm:datepicker name="fecha" class="span24" value="${consumo?.fecha ?: new Date()}" id="fecha"/>
                </div>

            </div>

            <div class="row-fluid">

                <div class="span3">
                    Requisición
                    <div id="divRequisicion">
                    <g:select name="requisicion_name_x" id="requisicion_x" from="${''}" class="span12"  noSelection="[null: '--Seleccione una obra--']"/>
                    </div>
                </div>

                <div class="span3">
                    Bodega
                    <div id="divBodega">
                        <g:select name="bodega_name_x" id="bodega_x" from="${''}" class="span12"  noSelection="[null: '--Seleccione una obra--']"/>
                    </div>
                </div>

                <div class="span3" style="color: #01a; margin-left: 5px">
                    Recibe: <br>
                    <g:select name="recibe" id="recibe" from="${recibe}" class="span12" optionKey="id"
                              value="${consumo?.recibe?.id}" noSelection="[null: '--Seleccione--']"/>
                </div>

                <div class="span2" style="color: #01a; margin-left: 5px">
                    Transporta: <br>
                    <g:select name="transporta" id="transporta" from="${recibe}" class="span12" optionKey="id"
                              value="${consumo?.transporta?.id}" noSelection="[null: '--Seleccione--']"/>
                </div>

                <div class="span1" style="width: 50px; color: #01a">
                    Estado
                    <g:textField name="estado" value="${consumo?.estado ?: 'N'}" readonly="true"
                                 title="${consumo?.estado == 'R' ? 'Registrado' : 'Ingresado'}" class="span12"/>
                </div>
            </div>
        </g:form>
    </div>
    <g:if test="${consumo?.estado == 'N'}">
        <g:if test="${consumo?.id}">
            <div style="border-bottom: 1px solid black;padding-left: 50px;margin-top: 10px;position: relative;">
                <p class="css-vertical-text">Items</p>

                <div class="linea" style="height: 100px;"></div>

                <div class="row-fluid" style="margin-bottom: 5px">

                    <div class="span2">

                        <div style="display: inline-block">
                            Código
                        </div>
                        <input type="text" name="item.codigo" id="cdgo_buscar" class="span24">
                        <input type="hidden" id="item_id">
                        <input type="hidden" id="idItems">
                    </div>

                    <div class="span6">
                        Descripción
                        <input type="text" name="item.descripcion" id="item_desc" class="span11" disabled="disabled">
                    </div>

                    <div class="span1" style="margin-right: 0px;margin-left: -30px;">
                        Unidad
                        <input type="text" name="item.unidad" id="item_unidad" class="span8" disabled="true">
                    </div>

                    <div class="span1" style="margin-left: -5px !important;">
                        Cantidad
                        <input type="text" name="item.cantidad" class="span12" id="item_cantidad" value="0"
                               style="text-align: right">
                    </div>

                    <div class="span2">
                        P. Unitario
                        <input type="text" name="item.precio" class="span8" id="item_precio" value="1"
                               style="text-align: right; color: #44a;">
                    </div>

                    <g:if test="${consumo?.estado != 'R' || consumo?.estado != 'A'}">
                        <div class="span1" style="border: 0px solid black;height: 45px;padding-top: 22px;margin-left: 10px">
                            <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar"
                               id="btn_agregarItem">
                                <i class="icon-plus"></i>
                            </a>
                            <a class="btn btn-small btn-success btn-ajax hidden" href="#" rel="tooltip" title="Guardar"
                               id="btn_guardarItem">
                                <i class="icon-save"></i>
                            </a>
                            <a class="btn btn-small btn-primary btn-ajax hidden" href="#" rel="tooltip" title="Cancelar edición"
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

    <g:if test="${consumo?.id}">
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
                <g:each in="${items}" var="item" status="i">
                    <tr class="item_row " id="${item.id}">
                        <td class="col_hora" style="text-align: left">${item.composicion.item.codigo}</td>
                        <td class="col_hora" style="text-align: left">${item.composicion.item.nombre}</td>
                        <td class="col_rend rend" style="width: 50px;text-align: center">
                            ${item.composicion.item.unidad}
                        </td>
                        <td style="text-align: right" class="cant">
                            <g:formatNumber number="${item.cantidad}" format="##,###0" minFractionDigits="2"
                                            maxFractionDigits="2" locale="ec"/>
                        </td>
                        <td style="text-align: right" class="cant">
                            <g:formatNumber number="${item.precioUnitario}" format="##,#####0" minFractionDigits="5"
                                            maxFractionDigits="5" locale="ec"/>
                        </td>
                        <td style="text-align: right" class="cant">
                            <g:formatNumber number="${item.precioUnitario * item.cantidad}" format="##,#####0"
                                            minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
                        </td>
                        <td style="width: 50px;text-align: center" class="col_delete">
                            <g:if test="${consumo?.estado == 'N'}">
                                <a class="btn btn-small btn-success editarItem" href="#" rel="tooltip" title="Editar"
                                   data-id="${item.id}"
                                   data-cant="${item.cantidad}" data-nombre="${item.composicion.item.nombre}"
                                   data-precio="${item.precioUnitario}"
                                   data-unidad="${item.composicion.item.unidad}" data-item="${item.composicion.id}"
                                   data-codigo="${item.composicion.item.codigo}">
                                    <i class="icon-edit"></i>
                                </a>
                                <a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar"
                                   data-id="${item.id}">
                                    <i class="icon-trash"></i>
                                </a>
                            </g:if>
                        </td>
                    </tr>
                    <g:set var="total" value="${total + (item.precioUnitario * item.cantidad)}"/>
                </g:each>
                <g:if test="${items.size() > 0}">
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
                <g:select name="buscarPorCnsm" class="buscarPor" from="${listaCnsm}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterio" id="criterioCnsm" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarCnsm" class="ordenar" from="${listaCnsm}" style="width: 100%" optionKey="key"
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

<div id="buscarObra" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarPorObra" class="buscarPor" from="${listaObra}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterioObra" id="criterioCnsm" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarObra" class="ordenar" from="${listaObra}" style="width: 100%" optionKey="key"
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
                <g:select name="buscarGrupo" class="buscarPor"
                          from="['1': 'Materiales', '2': 'Mano de Obra', '3': 'Equipos']"
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
        var idAdquisicion = '${consumo?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de REGISTRADO de la requisición?",
            title: "Quitar registro de requisición",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'consumo', action: 'quitarRegistrar_ajax')}',
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
                                    $("#spanError").html("Error al cambiar el estado de la requisición");
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
        $("#dlgLoad").dialog("open")
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
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'consumo', action: 'eliminarItem_ajax')}',
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
        $("#item_precio").val(precio).addClass("readonly").attr("disabled", true);
        $("#item_unidad").val(unidad).addClass("readonly");
        $("#cdgo_buscar").val(codigo).addClass("readonly").attr("disabled", true);
        $("#btn_guardarItem").removeClass("hidden");
        $("#btn_agregarItem").addClass("hidden");
        $("#btnCancelarEdicion").removeClass("hidden");
    });

    $("#btnCancelarEdicion").click(function () {
        $("#idItems").val("");
        $("#item_id").val("");
        $("#item_cantidad").val(0);
        $("#item_desc").val("").removeClass("readonly");
        $("#item_precio").val("").removeClass("readonly").attr("disabled", false);
        $("#item_unidad").val("").removeClass("readonly");
        $("#cdgo_buscar").val("").removeClass("readonly").attr("disabled", false);
        $("#btn_guardarItem").addClass("hidden");
        $("#btn_agregarItem").removeClass("hidden")
        $("#btnCancelarEdicion").addClass("hidden")
    });

    var urlS = "${resource(dir:'images', file:'spinner_24.gif')}";
    var spinner = $("<img style='margin-left:15px;' src='" + urlS + "' alt='Cargando...'/>");

    $("#btnRegistrar").click(function () {
        var idRubro = '${consumo?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de este" + '<p style="margin-left: 42px">' + "consumo a " + '<strong style="color: #1a7031">' + "APROBADO" + "?" + '</strong>' + '</p>',
            title: "Registrar consumo",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $("#btnRegistrar").replaceWith(spinner);
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'consumo', action: 'registrar_ajax')}',
                            data: {
                                id: idRubro
                            },
                            success: function (msg) {
                                if (msg == 'ok') {
                                    $("#spanOk").html("Rubro registrado correctamente");
                                    $("#divOk").show();
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                } else {
                                    $("#spanError").html("Error al cambiar el estado del consumo a registrado");
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

    $("#btnQuitarRegistro").click(function () {
        var idRubroR = '${consumo?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de este" + '<p style="margin-left: 42px">' + "consumo a " +
                '<strong style="color: #ff5c34">' + "NO APROBADO" + "?" + '</strong>' + '</p>',
            title: "Quitar registro del consumo",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $("#btnQuitarRegistro").replaceWith(spinner);
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'consumo', action: 'desregistrar_ajax')}',
                            data: {
                                id: idRubroR
                            },
                            success: function (msg) {
                                if (msg == 'ok') {
                                    $("#spanOk").html("Se ha retirado el registro del consumo correctamente");
                                    $("#divOk").show();
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                } else {
                                    $("#spanError").html("Error al cambiar el estado del consumo a ingresado");
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
            title: 'Requisiciones'
        });

        $("#btn-consumos").click(function () {
            buscaConsumos();
        });

        function buscaConsumos() {
            var buscarPor = $("#buscarPorCnsm").val();
            var criterio = $("#criterioCnsm").val();
            var ordenar = $("#ordenarCnsm").val();
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'consumo', action:'listaDevoluciones')}",
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

        <g:if test="${consumo?.id}">

        $("#cdgo_buscar").dblclick(function () {
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
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'consumo', action:'listaItem')}",
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

        <g:if test="${!consumo?.id}">
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
                    ordenar: ordenar,
                    tipo: 2,
                    consumo: '${consumo?.id}'

                },
                success: function (msg) {
                    $("#divTablaObra").html(msg);
                }
            });
        }

        $("#borrar").click(function () {
            $.box({
                imageClass: "box_info",
                text: "Desea anular la Requisición,<br>¿Está Seguro?",
                title: "Alerta",
                iconClose: false,
                dialog: {
                    resizable: false,
                    draggable: false,
                    buttons: {
                        "Aceptar": function () {
                            $.ajax({
                                type: "POST", url: "${g.createLink(controller: 'consumo',action:'borrarConsumo')}",
                                data: "id=${consumo?.id}",
                                success: function (msg) {
                                    $("#dlgLoad").dialog("close")
                                    if (msg == "ok") {
                                        location.href = "${createLink(controller: 'consumo', action: 'consumo')}"
                                    } else {
                                        $.box({
                                            imageClass: "box_info",
                                            text: "Error: el consumo seleccionado no se pudo eliminar. Esta referenciado en las siguientes obras: <br>" + msg,
                                            title: "Alerta",
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
            var obra = $("#obra__id").val()
            var bdga = $("#bodega").val()
            var rcbe = $("#recibe").val()
            var trnp = $("#transporta").val()
            var tipo = $("#tipoConsumo").val()

            if (obra == '' || obra == null) {
                $.box({
                    imageClass: "box_info",
                    text: "Seleccione una obra",
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
                    if (tipo == 'null') {
                        $.box({
                            imageClass: "box_info",
                            text: "Seleccione un tipo de requisición",
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
                        if (rcbe == 'null') {
                            $.box({
                                imageClass: "box_info",
                                text: "Seleccione quien recibe",
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
                            if (trnp == 'null') {
                                $.box({
                                    imageClass: "box_info",
                                    text: "Seleccione quien transporta",
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
                                $("#frmRubro").submit()
                            }
                        }
                    }

                }
            }
        });

        function guardarDetalleConsumo(id) {
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'consumo', action: 'guardarDetalleConsumo_ajax')}',
                data: {
                    id: $("#idItems").val(),
                    composicion: id,
                    cantidad: $("#item_cantidad").val(),
                    precioUnitario: $("#item_precio").val(),
                    consumo: '${consumo?.id}'
                },
                success: function (msg) {
                    if (msg == 'ok') {
                        location.href = "${createLink(controller: 'consumo', action: 'consumo')}/" + '${consumo?.id}'
                    } else {
                        alert("Error al guardar")
                    }
                }
            });
        }

        <g:if test="${consumo}">

        $("#btn_agregarItem, #btn_guardarItem").click(function () {
//            console.log("valor:" + $('#item_desc').val().length);
            var id = $("#item_id").val();
            if ($('#item_desc').val().length == 0) {
                $.box({
                    imageClass: "box_info",
                    text: "No hay item que agregar al APU",
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
                return false
            }
            $("#dlgLoad").dialog("open")
            $.ajax({
                type: "POST", url: "${g.createLink(controller: 'consumo', action:'verificaItem')}",
                data: "id=" + id,
                success: function (msg) {
                    $("#dlgLoad").dialog("close");
                    if (msg == "ok") {
                        guardarDetalleConsumo(id);
                    }
                }
            });
        });
        </g:if>
        <g:else>
        $("#btn_agregarItem, #btn_guardarItem").click(function () {
            $.box({
                imageClass: "box_info",
                text: "Primero guarde el consumo o seleccione uno para editar",
                title: "Alerta",
                iconClose: false,
                dialog: {
                    resizable: false,
                    draggable: false,
                    buttons: {
                        "Aceptar": function () {
                        }
                    },
                    width: 500
                }
            });
        });
        </g:else>

    });
</script>
</body>
</html>